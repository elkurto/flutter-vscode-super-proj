import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp(appTitle: 'abm06_mouse_listener'));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appTitle});

  final String appTitle;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text(appTitle)),
        body: const MouseTrackerExample(),
      ),
    );
  }
}

class MouseTrackerExample extends StatefulWidget {
  const MouseTrackerExample({super.key});

  @override
  MouseTrackerExampleState createState() => MouseTrackerExampleState();
}

class MouseTrackerExampleState extends State<MouseTrackerExample> {
  Offset _mousePosition = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mouse Tracking Example')),
      body: Center(
        child: MouseRegion(
          onHover: (event) {
            setState(() {
              _mousePosition = event.localPosition;
            });
          },
          child: Container(
            width: 300,
            height: 200,
            color: Colors.blueGrey[100],
            alignment: Alignment.center,
            child: Text(
              'Mouse Position: (${_mousePosition.dx.toStringAsFixed(2)}, ${_mousePosition.dy.toStringAsFixed(2)})',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
