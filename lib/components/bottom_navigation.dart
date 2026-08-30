import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.grey[900],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(onPressed: () {}, child: Icon(Icons.home)),
          ElevatedButton(onPressed: () {}, child: Icon(Icons.info)),
          ElevatedButton(onPressed: () {}, child: Icon(Icons.search)),
          ElevatedButton(onPressed: () {}, child: Icon(Icons.notifications)),
          
        ],
      ),
    );
  }
}
