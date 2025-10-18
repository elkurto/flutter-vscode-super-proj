import 'package:flutter/material.dart';
import 'package:nna22_theme_shared/screens/home/home.dart';
import 'package:nna22_theme_shared/theme.dart';

void main() {
  // register the primaryTheme from :file:theme.dart
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
