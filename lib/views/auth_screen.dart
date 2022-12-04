import 'package:codeforces_visualizer/controllers/auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
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
                googleSignIn(context);
              },
              child: const Text('google sign in'),
            ),
            
          ],
        ),
      ),
    );
  }
}
