import 'package:codeforces_visualizer/controllers/auth.dart';
import 'package:flutter/material.dart';

class CFAuth2 extends StatelessWidget {
  static const routename = 'CFAuth2';
  const CFAuth2({super.key});

  @override
  Widget build(BuildContext context) {
    final routes = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('Press to verify'),
          onPressed: () async {
            Auth.auth_login(routes['userHandle'],routes['problem'], context);
          },
        ),
      ),
    );
  }
}
