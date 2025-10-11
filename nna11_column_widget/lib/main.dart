import 'package:flutter/material.dart';
import 'package:nna11_column_widget/home.dart';

void main() {
  runApp(const MaterialApp(home: Sandbox(), debugShowCheckedModeBanner: false));
}

// sandbox
class Sandbox extends StatelessWidget {
  const Sandbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sandbox',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.grey,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              color: Colors.red[200],
              padding: const EdgeInsets.all(20),
              child: const Text('Red'),
            ),
            Container(
              width: 200,
              color: Colors.green[200],
              padding: const EdgeInsets.all(20),
              child: const Text('Green'),
            ),
            Container(
              width: 300,
              color: Colors.blue[200],
              padding: const EdgeInsets.all(20),
              child: const Text('Blue'),
            ),
          ],
        ),
      ),
    );
  }
}
