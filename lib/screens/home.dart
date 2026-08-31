import 'package:flutter/material.dart';
import 'package:flutter_start/components/bottom_navigation.dart';
import 'package:flutter_start/components/navbar.dart';
import 'package:flutter_start/screens/cart.dart';
import 'package:flutter_start/screens/profile.dart';
import 'package:flutter_start/screens/search.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<String> _titles = ['Home', 'Cart', 'Search'];

  final List<Widget> _screens = [const HomeContent(), const CartScreen(), const SearchScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(titles: _titles[_currentIndex],),
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Footer(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name", style: TextStyle(color: Colors.black)),
                SizedBox(height: 10.0),
                Text(
                  "Abbas",
                  style: TextStyle(
                    color: Colors.yellow,
                    letterSpacing: 2.0,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30.0),
                Row(
                  children: [
                    Icon(Icons.email, color: Colors.grey[400]),
                    SizedBox(width: 10.0),
                    Text(
                      "abbaskhanshah10@gmail.com",
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ],
                ),
                SizedBox(height: 30.0),
                Row(
                  children: [
                    Icon(Icons.phone, color: Colors.grey[400]),
                    SizedBox(width: 10.0),
                    Text(
                      "+92 3122537050",
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ],
                ),
                SizedBox(height: 30.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyProfile(name: "Abbas"),
                        ),
                      );
                    },
                    child: Text("Show"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
