import 'package:flutter/material.dart';
import 'package:frontend/auth/auth_serivce.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final authSerivce = AuthSerivce();

  void logout() async {
    await authSerivce.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final email = authSerivce.getCurrentUserEmail();

    return Scaffold(
      appBar: AppBar(title: const Text("Profile"),
      actions: [
        IconButton(onPressed: logout, icon: const Icon(Icons.logout
        )),
      ],
    ),

    body: Center(child: Text(email.toString())),
    );
  }
}