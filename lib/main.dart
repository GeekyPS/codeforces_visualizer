import 'dart:convert';

import 'package:codeforces_visualizer/views/auth_screen.dart';
import 'package:codeforces_visualizer/views/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';

import 'views/home_screen.dart';

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

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) =>
              snapshot.hasData ? UserProfile() : UserProfile()),
    );
  }
}

Future<void> get_login(String UserHandle) async {
  final response = await http.get(
      Uri.parse('https://codeforces.com/api/user.status?handle=$UserHandle'));

  final read = jsonDecode(response.body);
  print(read);
  //print(read['result'][0]);
}

class MyHomePage extends StatelessWidget {
  var _userHandle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 200,
          child: TextField(
            onSubmitted: (value) => {
              _userHandle = value,
              print(_userHandle),
              get_login(_userHandle),
            },
          ),
        ),
      ),
    );
  }
}
