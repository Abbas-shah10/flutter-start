import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget {
  final String? name;
  const MyProfile({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(appBar: AppBar(title: Text("WElcome to your Profile! $name "))),
    );
  }
}
