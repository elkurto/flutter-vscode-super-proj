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
  int? _prevMillis = null;
  Size _size = Size(200, 200);
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
        _size = MediaQuery.of(context).size;

        debugPrint("_size =${_size.width},${_size.height}");
        int nowMillis = DateTime.now().millisecondsSinceEpoch;
        if (listParticle.isEmpty) {
          listParticle.addAll(
            List<Particle>.generate(50, (index) {
              return Particle.randomDir(
                index,
                _size.width / 2.0,
                _size.height / 2.0,
              );
            }),
          );
        }

        if (_prevMillis == null) {
          _prevMillis = nowMillis;
        } else {
          int dt = nowMillis - _prevMillis!;
          _prevMillis = nowMillis;
          for (Particle p in listParticle) {
            p.x += p.vx * dt;
            p.y += p.vy * dt;

            if (p.x <= 0.0 ||
                p.y <= 0.0 ||
                _size.width <= p.x ||
                _size.height <= p.y) {
              p.x = _size.width / 2.0;
              p.y = _size.height / 2.0;
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
    return Container(
      decoration: BoxDecoration(color: Colors.black),
      child: CustomPaint(
        size: MediaQuery.of(context).size,
        painter: ParticlePainter(listParticle),
      ),
    );
  }
}

class Particle {
  int id;
  double x;
  double y;
  double vx; // pixel/millis
  double vy; // pixel/millis

  static double v0 = 0.005;
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
