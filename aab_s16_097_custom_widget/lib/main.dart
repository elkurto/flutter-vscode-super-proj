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

class MyHomePage extends StatefulWidget {
  final theme;
  const MyHomePage({this.theme, Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.theme.primaryColor,
        foregroundColor: widget.theme.secondaryHeaderColor,
        title: Text('AppBar in MyHomePage'), //
      ),
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Counter Worked', style: TextStyle(fontSize: 30)),
            Text(
              _count.toString(),
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ], //children
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          incrementCount();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void incrementCount() {
    setState(() {
      _count += 1;
    });
  }
}
