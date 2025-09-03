import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp(appTitle: 'On Key X'));
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
        body: const MyFormWidgetWithOnKeyHandler(),
      ),
    );
  }
}

final List<KeyboardKey> listKeyVowel = List.of([
  LogicalKeyboardKey.keyA,
  LogicalKeyboardKey.keyE,
  LogicalKeyboardKey.keyI,
  LogicalKeyboardKey.keyO,
  LogicalKeyboardKey.keyU,
], growable: false); // listKeyVowel

class MyFormWidgetWithOnKeyHandler extends StatelessWidget {
  const MyFormWidgetWithOnKeyHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Focus(
          onKeyEvent: (node, event) {
            // prevent typing vowels -- allow non-vowel
            return (listKeyVowel.contains(event.logicalKey)
                ? KeyEventResult.handled
                : KeyEventResult.ignored);
          },
          child: TextField(key: super.key),
        ),
      ],
    );
  }
}
