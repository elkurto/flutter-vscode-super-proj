import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color _colorSelected = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).secondaryHeaderColor,
        title: Text('AppBar in HomePage'), //
      ),
      backgroundColor: const Color.fromARGB(255, 176, 227, 250),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selected Color',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: BoxBorder.all(color: Colors.black, width: 5.0),
                color: _colorSelected,
              ),
              height: 100,
              width: 100,
              margin: EdgeInsets.only(bottom: 20),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setColorSelected(Colors.red);
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(Colors.red),
                  ),
                  child: Text('Red'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setColorSelected(Colors.green);
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(
                      Colors.green,
                    ),
                  ),
                  child: Text('Green'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setColorSelected(Colors.blue);
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(Colors.blue),
                  ),
                  child: Text('Blue'),
                ),
              ],
            ),
          ], //children
        ),
      ),
    );
  }

  void setColorSelected(Color colorSelected) {
    setState(() {
      _colorSelected = colorSelected;
    });
  }
}
