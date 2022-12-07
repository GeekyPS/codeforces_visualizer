import 'package:codeforces_visualizer/controllers/auth.dart';
import 'package:flutter/material.dart';

class CFAuth extends StatelessWidget {
  static const routename = '/CFAuth';

  const CFAuth({super.key});

  @override
  Widget build(BuildContext context) {
    String userHandle;

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 200,
          child: TextField(
            onSubmitted: (value) => {
              userHandle = value,
              Auth.get_login(userHandle, context),
            },
          ),
        ),
      ),
    );
  }
}
