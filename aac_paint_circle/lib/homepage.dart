import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.black),
        child: Stack(
          children: [
            CustomPaint(
              size: MediaQuery.of(context).size,
              painter: SimplePainter(),
            ),
          ], //end 'Stack.children'
        ),
      ),
    );
  }
}

class SimplePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    Paint cirlePaint = Paint()
      ..color = Colors.pinkAccent
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 250, cirlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
