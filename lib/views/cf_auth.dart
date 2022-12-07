import 'dart:convert';
import 'dart:math';

import 'package:codeforces_visualizer/controllers/auth.dart';
import 'package:flutter/material.dart';




class CFAuth extends StatelessWidget {
  static const routename = '/CFAuth';

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
              Auth.get_login(_userHandle, context),
            },
          ),
        ),
      ),
    );
  }
}
