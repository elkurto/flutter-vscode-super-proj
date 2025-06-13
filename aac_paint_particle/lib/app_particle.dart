import 'dart:math';
import 'package:flutter/material.dart';

class AppParticleWidget extends StatefulWidget {
  const AppParticleWidget({super.key});

  @override
  State<AppParticleWidget> createState() => _AppParticleWidgetState();
}

class _AppParticleWidgetState extends State<AppParticleWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  bool _loaded = false;
  DateTime? dateTimePrev = null;
  int dt = 20;
  Size? size = null;
  List<Particle> listParticle = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 100),
    );
    _controller!.repeat();
    _controller!.addListener(
      () => setState(() {
        // update state
        size ??= MediaQuery.of(context).size;

        debugPrint("_size =${size!.width},${size!.height}");

        DateTime dateTimeNow = DateTime.now();
        if (listParticle.isEmpty) {
          listParticle.addAll(
            List<Particle>.generate(50, (index) {
              return Particle.randomDir(
                index,
                size!.width / 2.0,
                size!.height / 2.0,
              );
            }),
          );
        }

        if (dateTimePrev == null) {
          dateTimePrev = dateTimeNow;
        } else {
          int dt = dateTimeNow.difference(dateTimePrev!).inMilliseconds;
          dateTimePrev = dateTimeNow;
          for (Particle p in listParticle) {
            p.x += p.vx * dt;
            p.y += p.vy * dt;

            if (p.x <= 0.0 ||
                p.y <= 0.0 ||
                size!.width <= p.x ||
                size!.height <= p.y) {
              p.x = size!.width / 2.0;
              p.y = size!.height / 2.0;
            }
          }
        }

        _loaded = true;
      }),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return const Center(child: Text('loading...'));
    }
    size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(color: Colors.black),
      child: CustomPaint(size: size!, painter: ParticlePainter(listParticle)),
    );
  }
}

class Particle {
  int id;
  double x;
  double y;
  double vx; // pixel/millis
  double vy; // pixel/millis

  static double v0 = 0.05;
  Particle(this.id, this.x, this.y, this.vx, this.vy);

  // a factory constructor -- because decent languages use biz logic in ctor
  factory Particle.randomDir(int id, double x, double y) {
    double theta = Random().nextDouble() * 2 * pi;
    return Particle(id, x, y, v0 * cos(theta), v0 * sin(theta));
  }
}

class ParticlePainter extends CustomPainter {
  final List<Particle> listParticle;
  final Paint cirlePaint = Paint()
    ..color = Colors.pinkAccent
    ..style = PaintingStyle.fill;

  // pass drawables to Painter via Ctor
  ParticlePainter(this.listParticle);

  @override
  void paint(Canvas canvas, Size size) {
    for (Particle p in listParticle) {
      canvas.drawCircle(Offset(p.x, p.y), 10.0, cirlePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
