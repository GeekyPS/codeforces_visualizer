import 'package:codeforces_visualizer/controllers/user_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('press me'),
          onPressed: () {
            UserData.fetchUsers(
                ['Geeky_PS', 'akshaykhandelwal', 'letsintegreat']);
          },
        ),
      ),
    );
  }
}
