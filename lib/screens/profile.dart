import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String? name;
  const ProfileScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(appBar: AppBar(title: Text("WElcome to your Profile! $name "))),
    );
  }
}
