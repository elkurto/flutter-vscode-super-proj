import 'package:abm08_mouse_key_listener/gamescreenwidget.dart' show GameScreenWidget;
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp(appTitle: 'abm08_mouse_key_listener'));
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
