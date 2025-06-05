import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(primarySwatch: Colors.deepPurple);

    return MaterialApp(
      home: MyHomePage(theme: theme),
      title: 'Flutter Demo',
    );
  }
}

class MyHomePage extends StatelessWidget {
  final theme;
  const MyHomePage({this.theme, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // fmtcomment
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        foregroundColor: theme.secondaryHeaderColor,
        title: Text('AppBar in MyHomePage'), //
      ),
      backgroundColor: Colors.lightBlue,
    );
  }
}
