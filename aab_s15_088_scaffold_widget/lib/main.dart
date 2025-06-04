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
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(secondary: Colors.pink),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Scaffold - AppBar'),
          backgroundColor: theme.primaryColor,
          centerTitle: true,
          foregroundColor: theme.secondaryHeaderColor,
        ),
        body: Center(
          child: Text(
            'Hello Body',
            style: TextStyle(fontSize: 36.0, decorationThickness: 1.3),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            debugPrint('Button Clicked');
          },
          backgroundColor: theme.primaryColorDark,
          foregroundColor: theme.primaryColorLight,
          child: const Icon(Icons.navigation),
        ),
      ),
    );
  }
}
