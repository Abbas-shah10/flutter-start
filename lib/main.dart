import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: HomePage(),
));

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    appBar: AppBar(
      title: Text("Hello gang!"),
      centerTitle: true,
      backgroundColor: Colors.deepOrangeAccent,
    ),
    body: Center(
      child: Text(
        "Hello Ninjas",
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
          color: Colors.grey[600],
          fontFamily: 'IndieFlower',
        ),
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () => {},
      backgroundColor: Colors.deepOrange,
      foregroundColor: Colors.black,
      child: Text("Click"),
    ),
  );
  }
}