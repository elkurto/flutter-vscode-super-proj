import 'package:flutter/material.dart';
import 'package:nna57_routes_and_screens/screens/home/home.dart';
import 'package:nna57_routes_and_screens/theme.dart';
//import 'package:nna57_routes_and_screens/screens/create/create.dart';

void main() {
  runApp(MaterialApp(theme: primaryTheme, home: const Home())); // reinstate later

  // show create screen for debugging and feedback
  // runApp(MaterialApp(theme: primaryTheme, home: const Create()));
}

// sandbox
class Sandbox extends StatelessWidget {
  const Sandbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sandbox'), backgroundColor: Colors.grey),
      body: const Text('sandbox'),
    );
  }
}
