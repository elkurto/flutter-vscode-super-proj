import 'dart:async';
import 'dart:collection';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

    _gameState.loadImageAssets();
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
      child: CustomPaint(
        painter: SpriteGamePainter(_gameState, _controller),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class SpriteGamePainter extends CustomPainter {
  final GameState gameState;
  final Animation<double> animation;

  SpriteGamePainter(this.gameState, this.animation) : super(repaint: animation);

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

class Sprite {
  ui.Image image;
  double sx = 0.0;
  double sy = 0.0;
  double sw = 50.0;
  double sh = 50.0;
  double dx = 100.0;
  double dy = 100.0;
  double dw = 50.0;
  double dh = 50.0;
  final Paint paintBackground = Paint()..color = Color(0xFF000000);
  double vx = 5.0 / 1000.0;
  double vy = 5.0 / 1000.0;
  double theta = 45.0 * pi / 180.0;
  double vtheta = 5.0 / 1000.0;
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
  void act(GameState gameState) {
    dx = gameState.dt * vx + dx;
    dy = gameState.dt * vy + dy;
    if (dx < 0 ||
        gameState.size!.width < dx ||
        dy < 0 ||
        gameState.size!.height < dy) {
      dx = gameState.size!.width / 2;
      dy = gameState.size!.height / 2;
    }
    theta = theta + vtheta * gameState.dt;
  }

  void draw(Canvas canvas, GameState gameState) {
    Rect rectSrc = Rect.fromLTWH(sx, sy, sw, sh);
    Rect rectDest = Rect.fromLTWH(dx, dy, dw, dh);

    // draw boomerang 01
    canvas.save(); // must save to restore // must restore to avoid side effects
    canvas.translate(1 * (dx + dw / 2), 1 * (dy + dh / 2));
    canvas.rotate(theta); // rotate at 1 * vtheta
    canvas.translate(-1 * (dx + dw / 2), -1 * (dy + dh / 2));
    canvas.drawImageRect(image, rectSrc, rectDest, paintBackground);
    canvas.restore(); // reset the transform // to avoid side effects.

    // draw boomerang 02
    canvas.save(); // must save to restore // must restore to avoid side effects
    canvas.transform(Matrix4.identity().storage);
    canvas.translate(1 * (dx + dw / 2), 1 * (dy + dh / 2));
    canvas.rotate(2 * theta); // rotate at 2 * vtheta
    canvas.translate(-1 * (dx + dw / 2), -1 * (dy + dh / 2));
    canvas.drawImageRect(image, rectSrc, rectDest, paintBackground);
    canvas.restore(); // reset the transform // to avoid side effects.
  }
}

Symbol symbolImageBoomerang = Symbol("boomerang");

class GameState {
  Size? size;
  int? prevEpochMillis;
  int dt = 20;
  final Map<Symbol, ui.Image> mapSymbolToImage = HashMap();
  final List<Sprite> listSprite = [];
  final List<String> listAssetFilename = ["assets/boomerang.000.50x50.png"];
  int nImageLoaded = 0;

  // final matrix4x4ResetTransform = Float64List.fromList([
  //   1.0, 0.0, 0.0, 0.0, // row 1
  //   0.0, 1.0, 0.0, 0.0, // row 2
  //   0.0, 0.0, 1.0, 0.0, // row 3
  //   0.0, 0.0, 0.0, 1.0, // row 4
  // ]); // does not work
  final matrix4x4ResetTransform = Matrix4.identity();

  void loadImageAssets() {
    print("in loadImageAssets");
    Future<ui.Image> futureUiImage = loadImageAsync(listAssetFilename[0]);

    futureUiImage.then(initSpriteFromLoadedImage);
  }

  Future<ui.Image> loadImageAsync(String assetFilename) async {
    print("in loadImageAsync");

    // this block works 100%
    ImmutableBuffer immutableBuffer = await rootBundle.loadBuffer(
      assetFilename,
    );
    var codec = await ui.instantiateImageCodecFromBuffer(immutableBuffer);
    var frame = await codec.getNextFrame();
    return frame.image;
  }

  void initSpriteFromLoadedImage(ui.Image image) {
    print("in initSpriteFromLoadedImage");
    Sprite sprite = Sprite(image, 0, 0, 50, 50, 100, 100, 50, 50);
    mapSymbolToImage[symbolImageBoomerang] = image;
    listSprite.add(sprite);
    nImageLoaded += 1;
  }

  bool isLoaded() {
    // print(
    //   "size =$size && listSprite.length =${listSprite.length} && listAssetFilename =${listAssetFilename.length}",
    // );
    return (size != null && listSprite.length == nImageLoaded);
  }

  void act() {
    if (isLoaded()) {
      for (Sprite sprite in listSprite) {
        sprite.act(this);
      }
    }
  }

  void draw(Canvas canvas) {
    if (isLoaded()) {
      for (Sprite sprite in listSprite) {
        sprite.draw(canvas, this);
      }
    }
  }

  void dispose() {
    for (var key in mapSymbolToImage.keys) {
      ui.Image? uiImage = mapSymbolToImage[key];
      if (uiImage != null) {
        uiImage.dispose();
      }
    }
  }

  void resetTransform(Canvas canvas) {
    canvas.transform(matrix4x4ResetTransform.storage);
  }
}
