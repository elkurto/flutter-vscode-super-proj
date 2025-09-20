import 'package:abm07_mouse_key_listener/gamescreenwidget.dart' show GameScreenWidget;
import 'package:abm07_mouse_key_listener/gamestate.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp(appTitle: 'abm07_mouse_key_listener'));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appTitle});

  final String appTitle;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,

      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: Scaffold(
        appBar: AppBar(title: Text(appTitle)),
        backgroundColor: Colors.red,
        body: Center(child: const GameScreenWidget()),
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
  final GameState gameState = GameState.instance;

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
          // create a 300x200 window and track mouse only in this window.
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
