import 'dart:math';
import 'package:flutter/material.dart';

class GameState {
  GameState(Animation<double> animation);

  bool loaded = false;
  bool shouldRepaint = true;
  int dtSinceRepaint = 10000;
  int dt = 20;
  Size? size;
  DateTime? dateTimePrev;
  List<Particle> listParticle = [];
  Animation<double>? animation;

  bool isLoaded() {
    return loaded;
  }

  void act() {
    // update state

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
      dt = dateTimeNow.difference(dateTimePrev!).inMilliseconds;

      dtSinceRepaint += dt;
      if (dtSinceRepaint >= 20) {
        shouldRepaint = true;
        dtSinceRepaint = 0;
      }

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
  }
}

class AppParticleWidget extends StatefulWidget {
  const AppParticleWidget({super.key});

  @override
  State<AppParticleWidget> createState() => _AppParticleWidgetState();
}

class _AppParticleWidgetState extends State<AppParticleWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  late final GameState _gameState; //= GameState(_animation);
  late final CustomPaint _customPaint = CustomPaint(
    size: _gameState.size!,
    painter: ParticlePainter(_gameState),
  );
  //bool _loaded = false;
  //DateTime? dateTimePrev = null;
  //int dt = 20;
  //Size? size = null;
  //List<Particle> listParticle = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
    _animation = Tween(begin: 0.0, end: 100.0).animate(_controller);
    _controller.repeat();
    _gameState = GameState(_animation);
    _gameState.loaded = true;

    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_gameState.isLoaded()) {
      return const Center(child: Text('loading...'));
    }
    _gameState.size ??= MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(color: Colors.black),
      child: _customPaint,
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
  //final List<Particle> listParticle;
  //final Animation<double> animation;

  final GameState gameState;
  final Paint cirlePaint = Paint()
    ..color = Colors.pinkAccent
    ..style = PaintingStyle.fill;

  // pass drawables to Painter via Ctor
  ParticlePainter(this.gameState) : super(repaint: gameState.animation);

  @override
  void paint(Canvas canvas, Size size) {
    gameState.size = size;
    gameState.act();
    print("gameState.dateTimePrev =${gameState.dateTimePrev}");
    List<Particle> listParticle = gameState.listParticle;
    for (Particle p in listParticle) {
      canvas.drawCircle(Offset(p.x, p.y), 10.0, cirlePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
    //(gameState.dt > 5);
  }
}
