import 'package:flutter/material.dart';
import 'package:flutter_start/screens/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text(
          "Just Info Card",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name", style: TextStyle(color: Colors.grey[300])),
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
                    MaterialPageRoute(builder: (context) => MyProfile(name: "Abbas")),
                  );
                },
                child: Text("Show"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
