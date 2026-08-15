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
      child: Text("Hello!"),
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