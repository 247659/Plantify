import 'package:flutter/material.dart';
import 'package:frontend/auth/auth_serivce.dart';
import 'package:frontend/pages/plant_add_page.dart';

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
    final accessToken = authSerivce.getCurrentUserAccessToken();

    return Scaffold(
      appBar: AppBar(title: const Text("Profile"),
      actions: [
        IconButton(onPressed: logout, icon: const Icon(Icons.logout
        )),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PlantAddPage()),
            );
          },
        ),
      ],
    ),
    body: ListView(
      children: [
        Center(child: Text(email.toString())),

        const SizedBox(height: 12),

        Center(child: Text(accessToken.toString()),)
      ],
    )
    );
  }
}