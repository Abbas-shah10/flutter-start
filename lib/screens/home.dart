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
            margin: EdgeInsets.only(bottom: 14.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text("username", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight(500)),),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 16.0),
            child: TextField()
          ),
          Row(
            children: [
              Text("Email", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight(500)),),
            ],
          ),
          Container(
            margin: EdgeInsets.only(bottom: 16.0),
            child: TextField()
          ),
          SizedBox(
            child: ElevatedButton(onPressed: () {}, child: Text("Submit"))
          )
        ],
      ),
    );
  }
}
