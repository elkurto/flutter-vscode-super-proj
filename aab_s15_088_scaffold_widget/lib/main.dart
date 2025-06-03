import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Scaffold - AppBar'),
          backgroundColor: Color.fromARGB(255, 35, 120, 255),
          centerTitle: true,
          foregroundColor: Color(0xFFFFFFFFFF),
        ),
        body: Center(child: Text('Hello Body')),
      ),
    );
  }
}
