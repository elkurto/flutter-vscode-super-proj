import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp(appTitle: 'Focus.onKeyEvent'));
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter a search term',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your username',
            ),
          ),
        ),
        Focus(
          onKeyEvent: (node, event) {
            // prevent typing vowels -- allow non-vowel
            return (listKeyVowel.contains(event.logicalKey)
                ? KeyEventResult.handled
                : KeyEventResult.ignored);
          },
          child: Padding(
            // format
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter text -prevent vowels',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
