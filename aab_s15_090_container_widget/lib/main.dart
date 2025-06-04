// main.dart  - // aab_s15_090_container_widget/lib/main.dart

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
        body: Container(
          alignment: Alignment.center,
          color: Colors.yellow,
          child: Text('Hello Body', style: TextStyle(fontSize: 36.0)),
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
