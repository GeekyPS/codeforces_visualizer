import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';




Future<void> googleSignIn(context) async {
  final googleSignIn = GoogleSignIn();
  final googleAccount = await googleSignIn.signIn();
  if (googleAccount != null) {
    final googleAuth = await googleAccount.authentication;

    if (googleAuth.accessToken != null && googleAuth.idToken != null) {
      try {
        await FirebaseAuth.instance.signInWithCredential(
            GoogleAuthProvider.credential(
                accessToken: googleAuth.accessToken,
                idToken: googleAuth.idToken));
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
      } on FirebaseException catch (error) {
        print(error.message);
      }
    }
  }
}

Future<void> google_logout(context) async {
  final googleSignIn = GoogleSignIn();
  await googleSignIn.disconnect();
  FirebaseAuth.instance.signOut();
}

