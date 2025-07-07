import 'dart:collection';
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
  final GameState _gameState =GameState();
  @override
  void initState() {
    super.initState();
    _controller.duration = duration;
    _controller.repeat();
    _controller.addListener(_update);
    

  }

  void _update() {
    setState(() => _gameState.act())
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

Symbol symbolImageBoomerang = Symbol("boomerang");

class GameState {
  Size? size;
  int? prevEpochMillis;
  int dt = 20;
  final Map<Symbol, ui.Image> mapSymbolToImage = HashMap();
  final List<Sprite> listSprite = [];
  
  GameState() {
    //Image image = Image.asset("assets/boomerange.000.50x50.png");
    //mapNameToImage["boomerang"] = image;
    if (mapSymbolToImage.containsKey(symbolImageBoomerang)) {}
    loadImageAssets();
  }
  
  void loadImageAssets() {
    Future<ui.Image> futureUiImage = loadImageAsync(
      "assets/boomerang.000.50x50.png",
    );

    futureUiImage.then(initSpriteFromLoadedImage);
  }

  Future<ui.Image> loadImageAsync(String assetFilename) async {
    ImmutableBuffer immutableBuffer = await ImmutableBuffer.fromAsset(
      assetFilename,
    );
    ui.Codec codec = await ui.instantiateImageCodecFromBuffer(immutableBuffer);
    ui.FrameInfo frameInfo = await codec.getNextFrame();
    return frameInfo.image;
  }

  void initSpriteFromLoadedImage(ui.Image image) {
    Sprite sprite = Sprite(image, 0, 0, 50, 50, 0, 0, 50, 50);
    mapSymbolToImage[symbolImageBoomerang] = image;
    listSprite.add(sprite);
  }

  void act() {
    if ( size != null) {
      for (Sprite sprite in listSprite) {
        sprite.act(this);
      }
    }
  }

  void draw(Canvas canvas) {

    if ( size != null) {
      for (Sprite sprite in listSprite) {
        sprite.draw( canvas, this);
      }
    }
  }
}
