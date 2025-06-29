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

    _controller.addListener(
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
          _gameState.dt = dateTimeNow
              .difference(_gameState.dateTimePrev!)
              .inMilliseconds;

          _gameState.dtSinceRepaint += _gameState.dt;
          if (_gameState.dtSinceRepaint >= 20) {
            _gameState.shouldRepaint = true;
            _gameState.dtSinceRepaint = 0;
          }

          _gameState.dateTimePrev = dateTimeNow;
          for (Particle p in _gameState.listParticle) {
            p.x += p.vx * _gameState.dt;
            p.y += p.vy * _gameState.dt;

            if (p.x <= 0.0 ||
                p.y <= 0.0 ||
                _gameState.size!.width <= p.x ||
                _gameState.size!.height <= p.y) {
              p.x = _gameState.size!.width / 2.0;
              p.y = _gameState.size!.height / 2.0;
            }
          }
        }
      }),
    );
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
    _gameState.size = MediaQuery.of(context).size;
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
