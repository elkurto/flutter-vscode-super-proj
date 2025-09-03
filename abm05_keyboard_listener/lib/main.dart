import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp(appTitle: 'abm05_keyboard_listener'));
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
        body: const MyKeyboardListenerWidget(),
      ),
    );
  }
}

class MyKeyboardListenerWidget extends StatefulWidget {
  const MyKeyboardListenerWidget({super.key});

  @override
  MyKeyboardListenerWidgetState createState() =>
      MyKeyboardListenerWidgetState();
}

class MyKeyboardListenerWidgetState extends State<MyKeyboardListenerWidget> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: (KeyEvent event) {
        if (event is KeyDownEvent) {
          print('Key Down: ${event.logicalKey.debugName}');
          // Add your specific logic here based on the pressed key
        }
      },
      child: Container(
        color: Colors.blueGrey[100],
        alignment: Alignment.center,
        child: const Text('Press a key'),
      ),
    );
  }
}
