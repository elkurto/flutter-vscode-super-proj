import 'package:flutter/material.dart';
import 'package:nna21_theme_custom/screens/home/home.dart';
import 'package:nna21_theme_custom/theme.dart';

void main() {
  // apply the theme defined in ./theme.dart (see :ThemeData:"primaryTheme" )
  runApp(MaterialApp(theme: primaryTheme, home: const Home()));
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
