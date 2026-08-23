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
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            color: Colors.blue,
            child: Text("Text1"),
          ),
          Container(
            padding: EdgeInsets.all(30.0),
            color: Colors.red[300],
            child: Text("Text2"),
          ),
          Container(
            padding: EdgeInsets.all(40.0),
            color: Colors.green,
            child: Text("Text3"),
          ),
        ],
      ),
    );
  }
}
