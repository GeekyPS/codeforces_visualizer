import 'dart:convert';

import 'package:codeforces_visualizer/views/auth_screen.dart';
import 'package:codeforces_visualizer/views/cf_auth2.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import './controllers/auth.dart';

import 'views/cf_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) =>
            snapshot.hasData ?  CFAuth() : const AuthScreen(),
      ),
      routes: {
        AuthScreen.routename:(context) => const AuthScreen(),
        CFAuth.routename:(context) =>  CFAuth(),
        CFAuth2.routename:(context) =>const CFAuth2()
        
      },
    );
  }
}
