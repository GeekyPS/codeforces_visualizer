import 'dart:convert';
import 'dart:math';

import 'package:codeforces_visualizer/controllers/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  Future<void> get_login(String UserHandle) async {
    final response = await http.get(
        Uri.parse('https://codeforces.com/api/user.status?handle=$UserHandle'));

    final read = jsonDecode(response.body);
    if (read['status'] == 'OK') {
      final response1 = await http.get(Uri.parse(
          'https://codeforces.com/api/problemset.problems?tags=implementation'));
      final body = jsonDecode(response1.body);
      final selected_problem = body['result']['problems'][100]['name'];
      

      final response2 = await http.get(Uri.parse(
          'https://codeforces.com/api/user.status?handle=$UserHandle&count=5'));

      final body2 = jsonDecode(response2.body);

      
      
      //if(body2['verdict']==='COMPILATION_ERROR' && body2['problem'])
      final email = await FlutterSecureStorage().read(key: 'email');
      await FirebaseFirestore.instance.collection('users').doc(email).set({
        'email': email,
        'cfid': UserHandle,
      });
    } else {
      print(read['comment']);
    }
    //print(read['result'][0]);
  }
  //print(read['result'][0]);

  @override
  Widget build(BuildContext context) {
    var _userHandle;

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 200,
          child: TextField(
            onSubmitted: (value) => {
              _userHandle = value,
              get_login(_userHandle),
            },
          ),
        ),
      ),
    );
  }
}
