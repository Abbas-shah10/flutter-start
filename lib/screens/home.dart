import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello gang!"),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Row(
        children: [
            Expanded(
              flex: 3,
              child: Container(
              padding: EdgeInsets.all(30.0),
              color: Colors.red,
              child: Text("1"),
              ),
            ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(30.0),
              color: Colors.blueAccent,
              child: Text("2"),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(30.0),
              color: Colors.amber,
              child: Text("3"),
            ),
          ),
        ],
      ),
    );
  }
}
