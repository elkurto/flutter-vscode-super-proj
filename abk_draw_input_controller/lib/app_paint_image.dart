import 'dart:async';
import 'dart:collection';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:abk_draw_input_controller/input_controller.dart';
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
  final FocusNode _focusNode = FocusNode();

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
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _gameState.size ??= MediaQuery.of(context).size;
    if (!_gameState.isLoaded()) {
      return const Center(child: Text('loading...'));
    }

    return KeyboardListener(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: (KeyEvent event) {
        InputController.handleKeyEvent(event);
      },
      child: Container(
        decoration: BoxDecoration(color: Colors.black),
        child: GestureDetector(
          onTapDown: (details) =>
              _gameState.addSpriteAtLocalOffset(details.localPosition),
          child: CustomPaint(
            painter: SpriteGamePainter(_gameState, _controller),
            child: const SizedBox.expand(),
          ),
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
  final Paint paintBackground = Paint()..color = Color(0xAA000000);
  double vx = 5.0 / 1000.0;
  double vy = 5.0 / 1000.0;
  double theta = 45.0 * pi / 180.0;
  double vtheta = 2.5 / 1000.0;
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
    /*
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

    canvas.translate(1 * (dx + dw / 2), 1 * (dy + dh / 2));
    canvas.rotate(-1 * theta); // rotate at 2 * vtheta
    canvas.translate(-1 * (dx + dw / 2), -1 * (dy + dh / 2));
    canvas.drawImageRect(image, rectSrc, rectDest, paintBackground);

    canvas.restore(); // reset the transform // to avoid side effects.
    */

    //// Extrapolated from code comments in source code
    ////   https://github.com/flutter/engine/blob/main/lib/ui/painting.dart#L5951

    // rotate clockwise (forward/ positive)
    var rSTransform = RSTransform.fromComponents(
      rotation: theta,
      scale: 1,
      // Center of the sprite relative to its rect
      anchorX: sw / 2, // center-of-rotation of sprite-space
      anchorY: sh / 2,
      // Location at which to draw the center of the sprite
      translateX: dx + sw / 2,
      translateY: dy + sw / 2,
    );

    // rotate counter-clockwise (backward/ negative)
    var rSTransformCCW = RSTransform.fromComponents(
      rotation: -1 * theta,
      scale: 1.5,
      // Center of the sprite relative to its rect
      anchorX: sw / 2, // center-of-rotation of sprite-space
      anchorY: sh / 2,
      // Location at which to draw the center of the sprite in viewport-space
      translateX: dx + sw / 2,
      translateY: dy + sw / 2,
    );
    canvas.save();

    canvas.drawAtlas(
      image,
      <RSTransform>[rSTransform, rSTransformCCW],
      <Rect>[
        Rect.fromLTWH(0, 0, 50, 50),
        Rect.fromLTWH(0, 0, 50, 50),
      ], // src rect in image_space
      null,
      null,
      null,
      paintBackground,
    );
    canvas.restore();
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
    nImageLoaded += 1;
    mapSymbolToImage[symbolImageBoomerang] = image;

    Sprite sprite = Sprite(image, 0, 0, 50, 50, 100, 100, 50, 50);
    listSprite.add(sprite);

    Sprite sprite2 = Sprite(image, 0, 0, 50, 50, 200, 100, 50, 50);
    listSprite.add(sprite2);
  }

  bool isLoaded() {
    // print(
    //   "size =$size && listSprite.length =${listSprite.length} && listAssetFilename =${listAssetFilename.length}",
    // );
    return (size != null && listAssetFilename.length == nImageLoaded);
  }

  void act() {
    if (isLoaded()) {
      for (Sprite sprite in listSprite) {
        sprite.act(this);
      }

      InputControllerSingleton inputController =
          InputControllerSingleton.instance;

      if (inputController.firePrimaryDown) {
        addSpriteAtLocalOffset(Offset(50, 200));
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

  void addSpriteAtLocalOffset(Offset offset) {
    ui.Image? image = mapSymbolToImage[symbolImageBoomerang];
    if (image != null) {
      Sprite sprite = Sprite(
        image,
        0,
        0,
        50,
        50,
        offset.dx - 50 / 2,
        offset.dy - 50 / 2,
        50,
        50,
      );
      listSprite.add(sprite);
    }
  }
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
