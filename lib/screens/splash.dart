import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_start/screens/home.dart';
import 'package:flutter_start/screens/user_info_screen.dart';
import 'package:flutter_start/services/user_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   @override
  void initState() {
    super.initState();
    _navigate(); // start the navigation logic after splash
  }

  // Waits 2 seconds, then checks if user data exists in local storage.
  // Navigates to the correct screen based on the result.
  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final userExists = await UserStorage.hasUser();

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => userExists
            ? const HomePage() // data found → go to home
            : const UserInfoScreen(), // no data → ask for info
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.flash_on, size: 100, color: Colors.white),
            SizedBox(height: 20),
            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}

