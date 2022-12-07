import 'package:codeforces_visualizer/controllers/auth.dart';

import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  static const routename = '/authscreen';
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                Auth.googleSignIn(context);
              },
              child: const Text('google sign in'),
            ),
          ],
        ),
      ),
    );
  }
}
