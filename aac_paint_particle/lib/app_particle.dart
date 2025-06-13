import 'dart:math';
import 'package:flutter/material.dart';

class GameState {
  bool loaded = false;
  int dt = 20;
  Size? size;
  DateTime? dateTimePrev;
  List<Particle> listParticle = [];
}

class AppParticleWidget extends StatefulWidget {
  const AppParticleWidget({super.key});

  @override
  State<AppParticleWidget> createState() => _AppParticleWidgetState();
}

class _AppParticleWidgetState extends State<AppParticleWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  //bool _loaded = false;
  //DateTime? dateTimePrev = null;
  //int dt = 20;
  //Size? size = null;
  //List<Particle> listParticle = [];
  GameState _gameState = GameState();

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
        _gameState.size ??= MediaQuery.of(context).size;

        DateTime dateTimeNow = DateTime.now();
        if (_gameState.listParticle.isEmpty) {
          _gameState.listParticle.addAll(
            List<Particle>.generate(50, (index) {
              return Particle.randomDir(
                index,
                _gameState.size!.width / 2.0,
                _gameState.size!.height / 2.0,
              );
            }),
          );
        }

        if (_gameState.dateTimePrev == null) {
          _gameState.dateTimePrev = dateTimeNow;
        } else {
          int dt = dateTimeNow
              .difference(_gameState.dateTimePrev!)
              .inMilliseconds;
          _gameState.dateTimePrev = dateTimeNow;
          for (Particle p in _gameState.listParticle) {
            p.x += p.vx * dt;
            p.y += p.vy * dt;

            if (p.x <= 0.0 ||
                p.y <= 0.0 ||
                _gameState.size!.width <= p.x ||
                _gameState.size!.height <= p.y) {
              p.x = _gameState.size!.width / 2.0;
              p.y = _gameState.size!.height / 2.0;
            }
          }
        }

        _gameState.loaded = true;
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
    if (!_gameState.loaded) {
      return const Center(child: Text('loading...'));
    }
    _gameState.size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(color: Colors.black),
      child: CustomPaint(
        size: _gameState.size!,
        painter: ParticlePainter(_gameState.listParticle, _gameState),
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
  final GameState gameState;
  final Paint cirlePaint = Paint()
    ..color = Colors.pinkAccent
    ..style = PaintingStyle.fill;

  // pass drawables to Painter via Ctor
  ParticlePainter(this.listParticle, this.gameState);

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
