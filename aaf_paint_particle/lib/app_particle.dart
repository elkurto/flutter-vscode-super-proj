import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';

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

class GameState {
  GameState();

  bool loaded = false;
  bool shouldRepaint = true;
  int dtSinceRepaint = 10000;
  int dt = 20;
  Size? size;
  DateTime? dateTimePrev;
  List<Particle> listParticle = [];
  //Animation<double>? animation;

  bool isLoaded() {
    return loaded;
  }

  void act() {
    // update state

    DateTime dateTimeNow = DateTime.now();
    if (listParticle.isEmpty) {
      listParticle.addAll(
        List<Particle>.generate(150, (index) {
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
  late final AnimationController _controller = AnimationController(
    vsync: this,
    upperBound: 100.0,
  );
  final Duration duration = const Duration(seconds: 20);
  late final GameState _gameState; //= GameState(_animation);

  @override
  void initState() {
    super.initState();
    _controller.duration = duration;
    _controller.repeat();

    _gameState = GameState();
    _gameState.loaded = true;

    _controller.addListener(() => setState(() => _gameState.act()));
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
      child: CustomPaint(
        painter: ParticlePainter(_gameState, _controller),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class ParticlePainter extends CustomPainter {
  final GameState gameState;
  final Animation<double> animation;
  final Paint circlePaint = Paint()
    ..color = Colors.pinkAccent
    ..style = PaintingStyle.fill;
  final Paint paintTriangleA = Paint()
    ..color = Colors.purple
    ..style = PaintingStyle.fill;
  final Paint paintTriangleB = Paint()
    ..color = Colors.green
    ..style = PaintingStyle.fill;

  // pass drawables to Painter via Ctor
  ParticlePainter(this.gameState, this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    gameState.size = size;

    //print("gameState.dateTimePrev =${gameState.dateTimePrev}");
    List<Particle> listParticle = gameState.listParticle;
    for (Particle p in listParticle) {
      canvas.drawCircle(Offset(p.x, p.y), 10.0, circlePaint);
    }

    // draw a static purple (upward) triangle with the specified vertices
    final center = Offset(size.width / 2, size.height / 2);
    final vertices = Vertices(VertexMode.triangles, [
      center + Offset(0, -15),
      center + Offset(-14, 13),
      center + Offset(14, 13),
    ]);

    canvas.drawVertices(vertices, BlendMode.src, paintTriangleA);

    // draw a static multi-hued (downward) triangle with the specified vertices
    final centerB = Offset(size.width / 2, size.height / 2 + 30);

    final verticesB = Vertices(
      VertexMode.triangles,
      [
        centerB + Offset(0, 15),
        centerB + Offset(-14, -13),
        centerB + Offset(14, -13),
      ],
      colors: [
        // exactly one color per vertex
        Color(0xAA1A30F4), // blue, opacity=0.70
        Color(0xAACC00CC), // pink, opacity=0.70
        Color(0xAACCCC00), // lime, opacity=0.70
      ],
    );

    canvas.drawVertices(verticesB, BlendMode.src, paintTriangleA);

    // draw two static multi-hued triangles with the specified vertices
    final centerC = Offset(size.width / 2, size.height / 2 + 90);

    final verticesC = Vertices(
      VertexMode.triangles,
      [
        centerC + Offset(0, -25),
        centerC + Offset(-15, 0),
        centerC + Offset(15, 0),
        centerC + Offset(0, 25),
      ],
      colors: [
        // one color per vertex
        Color(0xCCFF0000), // red, opacity=CC , index=0
        Color(0xCC00FF00), // pink, opacity=CC, index=1
        Color(0xCC0000FF), // lime, opacity=CC, index=2
        Color(0xCC9933FF), // purple, opacity=CC, index=3
      ],
      indices: [
        0, 1, 2, // upper triangle in C
        1, 2, 3, // lower triangle in C
      ],
    );

    canvas.drawVertices(verticesC, BlendMode.src, paintTriangleA);

    // actually draw with vertices
    final centerD = Offset(size.width / 2 + 50, size.height / 2 + 90);
    final pt0 = centerD + Offset(0, -25);
    final pt1 = centerD + Offset(-15, 0);
    final pt2 = centerD + Offset(15, 0);
    final pt3 = centerD + Offset(0, 25);
    final listFloat32VertexXYD = Float32List.fromList([
      pt0.dx,
      pt0.dy,
      pt1.dx,
      pt1.dy,
      pt2.dx,
      pt2.dy,
      pt3.dx,
      pt3.dy,
    ]);
    final verticesD = Vertices.raw(VertexMode.triangles, listFloat32VertexXYD);
    canvas.drawVertices(verticesD, BlendMode.src, paintTriangleB);

    // E. draw with vertices with indeces
    final centerE = Offset(size.width / 2 + 100, size.height / 2 + 90);
    final pt0E = centerE + Offset(0, -25);
    final pt1E = centerE + Offset(-15, 0);
    final pt2E = centerE + Offset(15, 0);
    final pt3E = centerE + Offset(0, 25);
    final listFloat32VertexXYE = Float32List.fromList([
      pt0E.dx,
      pt0E.dy,
      pt1E.dx,
      pt1E.dy,
      pt2E.dx,
      pt2E.dy,
      pt3E.dx,
      pt3E.dy,
    ]);
    final indicesE = Uint16List.fromList([
      0, 1, 2, // upper triangle
      3, 1, 2, // lower triangle
    ]);
    final Paint paintE = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill;

    final verticesE = Vertices.raw(
      VertexMode.triangles,
      listFloat32VertexXYE,
      indices: indicesE,
    );
    canvas.drawVertices(verticesE, BlendMode.src, paintE);

    // F. draw with vertices with indices and "color per vertex"
    final centerF = Offset(size.width / 2 + 150, size.height / 2 + 90);
    final pt0F = centerF + Offset(0, -25);
    final pt1F = centerF + Offset(-15, 0);
    final pt2F = centerF + Offset(15, 0);
    final pt3F = centerF + Offset(0, 25);
    final listFloat32VertexXYF = Float32List.fromList([
      pt0F.dx,
      pt0F.dy,
      pt1F.dx,
      pt1F.dy,
      pt2F.dx,
      pt2F.dy,
      pt3F.dx,
      pt3F.dy,
    ]);
    final indicesF = Uint16List.fromList([
      0, 1, 2, // upper triangle
      3, 1, 2, // lower triangle
    ]);
    final Paint paintF = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill;

    final colorsF = Int32List.fromList([
      0xCCFF0000, // Color(0xCCFF0000).toARGB32(), // red, opacity=CC , index=0
      0xCC00FF00, // Color(0xCC00FF00).toARGB32(), // pink, opacity=CC, index=1
      0xCC0000FF, //  Color(0xCC0000FF).toARGB32(), // blue-purple, opacity=CC, index=2
      0xCC9933FF, // Color(0xCC9933FF).toARGB32(), // purple, opacity=CC, index=3
    ]);

    final verticesF = Vertices.raw(
      VertexMode.triangles,
      listFloat32VertexXYF,
      indices: indicesF,
      colors: colorsF, // one color per vertex
    );
    canvas.drawVertices(verticesF, BlendMode.src, paintF);

    // G -- example of canvas.drawPoints(...)  // rednders 3 white squares of strokeWidth=10

    final paintG = Paint()
      ..color = Color(0xCCFFFFFF)
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;
    final centerG = Offset(size.width / 2 + 190, size.height / 2 + 90);
    final pointsG = List<Offset>.from([
      centerG + Offset(0, 15),
      centerG,
      centerG + Offset(0, -15),
    ]);
    canvas.drawPoints(PointMode.points, pointsG, paintG);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
    //(gameState.dt > 5);
  }
}
