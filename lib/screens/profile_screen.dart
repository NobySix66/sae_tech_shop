import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: const [
            CircleAvatar(radius: 50, backgroundColor: Colors.grey),
            SizedBox(height: 16),
            Text('Nama Pengguna', style: TextStyle(fontSize: 22, color: Colors.white)),
            SizedBox(height: 8),
            Text('email@example.com', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
