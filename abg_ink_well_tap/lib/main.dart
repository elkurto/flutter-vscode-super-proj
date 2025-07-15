import 'package:flutter/material.dart';

/// src = https://api.flutter.dev/flutter/material/InkWell-class.html
/// Flutter code sample for [InkWell].

void main() => runApp(const InkWellExampleApp());

class InkWellExampleApp extends StatelessWidget {
  const InkWellExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('InkWell Sample')),
        body: ListView(
          scrollDirection: Axis.vertical,

          children: <Widget>[
            SizedBox(width: 160, child: Center(child: InkWellExample())),
            SizedBox(width: 160, height: 160, child: InkWellButton()),
          ],
        ),
      ),
    );
  }
}

class InkWellButton extends StatelessWidget {
  InkWellButton({super.key});
  final green = Color.fromARGB(255, 55, 255, 128);
  final blue = Color.fromARGB(255, 55, 128, 255);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: green,
      child: InkWell(
        child: IconButton(onPressed: () => {}, icon: const Icon(Icons.star)),
      ),
    );
  }
}

class InkWellExample extends StatefulWidget {
  const InkWellExample({super.key});

  @override
  State<InkWellExample> createState() => _InkWellExampleState();
}

class _InkWellExampleState extends State<InkWellExample> {
  double sideLength = 50;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: sideLength,
      width: sideLength,
      duration: const Duration(seconds: 2),
      curve: Curves.easeIn,
      child: Material(
        color: Colors.yellow,
        child: InkWell(
          onTap: () {
            setState(() {
              sideLength == 50 ? sideLength = 100 : sideLength = 50;
            });
          },
          child: Text("Click Me"),
        ),
      ),
    );
  }
}
