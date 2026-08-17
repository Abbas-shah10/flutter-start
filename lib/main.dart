import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: HomePage()));

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isVisible = false;

  void toggleVisibility() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello gang!"),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Container(
        color: Colors.grey[400],
        width: double.infinity,
        child: Center(
          child: isVisible
              ? const Text(
                  "Hello, I am visible now!",
                  style: TextStyle(fontSize: 24),
                )
              : const Text("Click The Button to see Magic"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrangeAccent,
        onPressed: toggleVisibility,
        child: const Text("Click"),
      ),
    );
  }
}
