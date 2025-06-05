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
      home: MyHomePage(),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            color: Colors.pink,
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

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
            Text(
              'Counter Worked',
              // style: TextStyle(fontSize: 30)),
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              _count.toString(),
              //style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              style: Theme.of(context).textTheme.headlineLarge,
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
