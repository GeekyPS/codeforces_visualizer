import 'dart:convert';
import 'dart:math';

import 'package:codeforces_visualizer/controllers/user_data.dart';
import 'package:codeforces_visualizer/models/submission.dart';
import 'package:codeforces_visualizer/views/cf_auth2.dart';
import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class Auth with ChangeNotifier {
  static Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
      throw 'Could not launch $url';
    }
  }

  static Future<bool> isSubmitted(
      String userHandle, String contestId, String index) async {
    List<Submission> submissions =
        await UserData.fetchUserSubmissions(userHandle);

    if (submissions[0].contestId.toString() == contestId &&
        submissions[0].problem.index == index) {
      return true;
    }
    return false;
  }

  static Future<void> googleSignIn(context) async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;

      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          await FirebaseAuth.instance.signInWithCredential(
            GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken,
              idToken: googleAuth.idToken,
            ),
          );
          final name = googleAccount.displayName;
          final imageUrl = googleAccount.photoUrl;
          final email = googleAccount.email;

          await const FlutterSecureStorage().write(key: 'email', value: email);

          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Hi, $name, your email id is $email'),
                  content:
                      CircleAvatar(child: Image.network(imageUrl ?? 'hello')),
                  actions: [
                    TextButton(
                      onPressed: () {},
                      child: const Text('next'),
                    ),
                    TextButton(
                        onPressed: () {
                          google_logout(context);
                        },
                        child: const Text('Logout'))
                  ],
                );
              });
        } on FirebaseException catch (_) {
          // print(error.message);
        }
      }
    }
  }

  static Future<void> google_logout(context) async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }

  static Future<List<String>> fetchRandomQuestion(String userHandle) async {
    const url = 'https://codeforces.com/api/problemset.problems';

    final response =
        await http.get(Uri.parse(url)); // handle http error as well

    final body = jsonDecode(response.body);
    var problemLink = 'https://codeforces.com/contest/';
    String name = '';
    String contestId = '';
    String index = '';
    if (body['status'] == 'OK') {
      var question_number = Random().nextInt(8000);
      List problems = body['result']['problems'];
      bool condition = await isSubmitted(
          userHandle,
          problems[question_number]['contestId'].toString(),
          problems[question_number]['index']);

      if (condition) {
        if (question_number < 8000) {
          question_number++;
        } else {
          question_number--;
        }
      }

      problemLink +=
          '${problems[question_number]['contestId']}/problem/${problems[question_number]['index']}';
      name = problems[question_number]['name'] as String;
      contestId = problems[question_number]['contestId'].toString();
      index = problems[question_number]['index'];
    } else {
      // handle error
    }

    List<String> returnList = [problemLink, name, contestId, index];
    return returnList;
  }

  late String contestId1;
  late String index1;

  static Future<void> get_login(String userHandle, BuildContext context) async {
    final response = await http.get(
        Uri.parse('https://codeforces.com/api/user.status?handle=$userHandle'));

    final body = jsonDecode(response.body);

    if (body['status'] == 'OK') {
      List<String> problem = await Auth.fetchRandomQuestion(userHandle);

      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                        'Submit a compilation error to question:-> "${problem[1]}"'),
                    TextButton(
                        onPressed: () async {
                          await _launchUrl(problem[0]);

                    
                          Navigator.of(context).pushNamed(CFAuth2.routename,
                              arguments: {
                                'problem': problem,
                                'userHandle': userHandle
                              });
                        },
                        child: Text(problem[0]))
                  ],
                ),
              ));
    } else {
      final snackbar = SnackBar(content: Text(body['comment']));

      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }

    //print(read['result'][0]);
  }

  static Future<void> auth_login(
      String userHandle, List<String> problem, BuildContext context) async {
    bool condition = await isSubmitted(userHandle, problem[2], problem[3]);

    if (condition) {
      final email = await const FlutterSecureStorage().read(key: 'email');
      await FirebaseFirestore.instance.collection('users').doc(email).set({
        'email': email,
        'cfid': userHandle,
      });
      const snackbar =
          SnackBar(content: Text('Congrats you are authenticated'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else {
      const snackbar =
          SnackBar(content: Text('you haven\'t made a submission yet'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
}
