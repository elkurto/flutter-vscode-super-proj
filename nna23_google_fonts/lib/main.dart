import 'package:flutter/material.dart';
import 'package:nna23_google_fonts/screens/home/home.dart';
import 'package:nna23_google_fonts/theme.dart';

void main() {
  runApp(MaterialApp(theme: primaryTheme, home: const Home(), debugShowCheckedModeBanner: false));
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
