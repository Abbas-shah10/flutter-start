import 'package:flutter/material.dart';
import 'package:flutter_start/components/bottom_navigation.dart';
import 'package:flutter_start/components/navbar.dart';
import 'package:flutter_start/screens/cart.dart';
import 'package:flutter_start/screens/profile.dart';
import 'package:flutter_start/screens/search.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyAppState();
}

class _MyAppState extends State<HomePage> {
  int _currentIndex = 0;

  final List<String> _titles = ['Home', 'Search', 'Cart', 'Profile'];

  final List<Widget> _screens = [
    const _HomeContent(),
    const SearchScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // Title changes automatically based on the active tab
        appBar: Navbar(titles: _titles[_currentIndex]),

        // IndexedStack shows only the active screen
        // but keeps all screens in memory (no rebuild on tab switch)
        body: IndexedStack(index: _currentIndex, children: _screens),

        bottomNavigationBar: BottomNavBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}

// ── Home tab content ──────────────────────────────────────────────────────────
// Kept as a private widget inside this file since it belongs to the Home tab.
class _HomeContent extends StatefulWidget {
  const _HomeContent();

  @override
  State<_HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<_HomeContent> {
  String inputName = '';
  final TextEditingController nameInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: [
          Text("Hello"),
        ],
      ),
    );
  }
}
