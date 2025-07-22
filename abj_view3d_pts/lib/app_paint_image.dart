import 'dart:collection';

import 'dart:math' as math;
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector_math;
import 'project.dart';

class AppPaintImageWidget extends StatefulWidget {
  const AppPaintImageWidget({super.key});

  @override
  State<AppPaintImageWidget> createState() => _AppPaintImageWidgetState();
}

class _AppPaintImageWidgetState extends State<AppPaintImageWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    upperBound: 100.0,
  );
  final Duration duration = const Duration(seconds: 20);
  final GameState _gameState = GameState();

  @override
  void initState() {
    super.initState();

    _gameState.init();
    _controller.duration = duration;
    _controller.repeat();
    _controller.addListener(_update);
  }

  void _update() {
    setState(() => _gameState.act());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _gameState.size ??= MediaQuery.of(context).size;
    if (!_gameState.isLoaded()) {
      return const Center(child: Text('loading...'));
    }

    return Container(
      decoration: BoxDecoration(color: Colors.black),
      child: GestureDetector(
        onTapDown: (details) => _gameState.handleTap(details.localPosition),
        child: CustomPaint(
          painter: SpriteGamePainter(_gameState, _controller),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}

class SpriteGamePainter extends CustomPainter {
  final GameState gameState;
  final Animation<double> animation;

  const SpriteGamePainter(this.gameState, this.animation)
    : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    gameState.size = size;
    gameState.draw(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class GameState {
  Size? size;
  int? prevEpochMillis;
  int dt = 20;
  int nImageLoaded = 0;
  double theta = 0; // radian
  double vtheta = math.pi / 10000; //  (pi radian / 10000 millisecond)
  final List<vector_math.Vector3> listPointOrig = <vector_math.Vector3>[
    vector_math.Vector3(0, 0, 0), // bottom corners of cube
    vector_math.Vector3(1, 0, 0),
    vector_math.Vector3(1, 0, 1),
    vector_math.Vector3(0, 0, 1),
    vector_math.Vector3(0, 1, 0), // top corners of cube
    vector_math.Vector3(1, 1, 0),
    vector_math.Vector3(1, 1, 1),
    vector_math.Vector3(0, 1, 1),
  ];
  List<vector_math.Vector3> listPointRotated = List.filled(
    8,
    vector_math.Vector3(0, 0, 0),
  );

  static const _palette = [
    Color(0xFFea1f25),
    Color(0xFF83AAF3),
    Color(0xFFf1ca00),
    Color(0xFFecddbe),

    Color(0xFF8C0307),
    Color(0xFF043CA3),
    Color(0xFF8B7506),
    Color(0xFF858585),
  ];

  final _paint = Paint()..color = Color(0xFF66EE66);

  init() {}

  bool isLoaded() {
    return (size != null);
  }

  void act() {
    if (isLoaded()) {
      if (prevEpochMillis == null) {
        prevEpochMillis = DateTime.now().millisecondsSinceEpoch;
      } else {
        int nowMs = DateTime.now().millisecondsSinceEpoch;
        dt = nowMs - prevEpochMillis!;
        theta += vtheta * dt;
        theta = theta % (2 * math.pi);
        prevEpochMillis = nowMs;
      }
    }
  }

  void draw(Canvas canvas) {
    if (isLoaded()) {
      var aspectRatio = size!.width / size!.height;

      for (final (i, point) in listPointOrig.indexed) {
        const pointSize = 5.0;
        var screenPoint = project(
          point,
          theta, //animation.value * math.pi * 2,
          aspectRatio,
        );

        var color = _palette[i % _palette.length];
        _paint.color = color;

        // Remaps coordinates from [-1, 1] to the [0, viewport].
        var x = (1.0 + screenPoint.x) * size!.width / 2;
        var y = (1.0 - screenPoint.y) * size!.height / 2;

        canvas.drawCircle(Offset(x, y), pointSize, _paint);
      }
    }
  }

  void dispose() {}

  void handleTap(Offset localOffset) {}
}

/*
TODOS
1. use drawAtlasRaw  (in lieu of drawImage) -- what is an RSTransform parameter 
2. make GameState a const , so that SpriteGamePainter and CustomPainter can be const.
3. add collision and inelastic collision
4. mesh rendering 
5. use Matrix4
6. faux 3d rendering
7. 2-3-4-tree in dart
8. navigation multiscreen  - see https://github.com/flutter/website/blob/main/examples/ui/navigation/README
9. adverts
10. persistent local storage of game state 
11. levels
12. game-physics-sym
13, sound controller

    // @done make several sprites
    // @done add touch events
    // @todo add swipe events
    // @todo render image to mesh or proceedural shader
*/
