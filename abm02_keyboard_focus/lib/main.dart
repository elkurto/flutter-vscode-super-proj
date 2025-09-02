import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Required for LogicalKeyboardKey

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('KeyboardListener Example')),
        body: const Center(child: KeyboardListenerExample()),
      ),
    );
  }
}

class KeyboardListenerExample extends StatefulWidget {
  const KeyboardListenerExample({super.key});

  @override
  State<KeyboardListenerExample> createState() =>
      _KeyboardListenerExampleState();
}

class _KeyboardListenerExampleState extends State<KeyboardListenerExample> {
  final FocusNode _focusNode = FocusNode();
  String _lastKey = 'None';

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _focusNode,
      autofocus: true, // Automatically requests focus when the widget is built
      onKeyEvent: (KeyEvent event) {
        if (event is KeyDownEvent) {
          setState(() {
            _lastKey = event.logicalKey.debugName ?? 'Unknown Key';
          });
          // Example: Perform an action on 'Enter' key press
          if (event.logicalKey == LogicalKeyboardKey.enter) {
            debugPrint('Enter key pressed!');
          }
        }
        // Return KeyEventResult.handled if you want to consume the event
        // and prevent it from being propagated further up the tree.
        return KeyEventResult.ignored; //@todo fix this
        // Allow other listeners to process the event
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Press any key to see its name:',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            'Last Key Pressed: $_lastKey',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // You can programmatically request focus if needed
              _focusNode.requestFocus();
            },
            child: const Text('Focus Me'),
          ),
        ],
      ),
    );
  }
}
