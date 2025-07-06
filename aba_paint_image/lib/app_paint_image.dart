import 'dart:collection';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    _controller.duration = duration;
    _controller.repeat();
    _controller.addListener(_update);
  }

  void _update() {
    setState(
      () {}, // @todo update gameState
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext buildContext) {
    return Text("@todo add canvas custompainter and render loaded image");
  }
}

class Sprite {
  ui.Image image;
  double sx = 0.0;
  double sy = 0.0;
  double sw = 50.0;
  double sh = 50.0;
  double dx = 0.0;
  double dy = 0.0;
  double dw = 50.0;
  double dh = 50.0;
  final Paint paintBackground = Paint()..color = Color(0x00000000);

  Sprite(
    this.image,
    this.sx,
    this.sy,
    this.sw,
    this.sh,
    this.dx,
    this.dy,
    this.dw,
    this.dh,
  );
  void act(GameState gameState) {}
  void draw(Canvas canvas, GameState gameState) {
    Rect rectSrc = Rect.fromLTWH(sx, sy, sw, sh);
    Rect rectDest = Rect.fromLTWH(dx, dy, dw, dh);
    canvas.drawImageRect(image, rectSrc, rectDest, paintBackground);
  }
}

class GameState {
  Size? size;
  int? prevEpochMillis;
  int dt = 20;
  final Map<String, Image> mapNameToImage = HashMap();
  final List<Sprite> listSprite = [];

  GameState() {
    Image image = Image.asset("assets/boomerange.000.50x50.png");
    mapNameToImage["boomerang"] = image;
  }
}
