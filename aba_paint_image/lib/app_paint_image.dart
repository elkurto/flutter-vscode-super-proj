import 'dart:async';
import 'dart:collection';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
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
  double dx = 0.0;
  double dy = 0.0;
  double dw = 50.0;
  double dh = 50.0;
  final Paint paintBackground = Paint()..color = Color(0xFF000000);

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
  final List<String> listAssetFilename = ["assets/boomerang.000.50x50.png"];
  GameState() {
    //Image image = Image.asset("assets/boomerange.000.50x50.png");
    //mapNameToImage["boomerang"] = image;
    if (mapSymbolToImage.containsKey(symbolImageBoomerang)) {}
  }

  void loadImageAssets() {
    print("in loadImageAssets");
    Future<ui.Image> futureUiImage = loadImageAsync(listAssetFilename[0]);

    futureUiImage.then(initSpriteFromLoadedImage);
  }

  Future<ui.Image> loadImageAsync(String assetFilename) async {
    print("in loadImageAsync");
    // ImmutableBuffer immutableBuffer = await rootBundle.loadBuffer(
    //   assetFilename,
    // );  ?? will this work

    // Image image =Image(image: AssetImage(assetFilename)); // will this work if convrted to ui.Image ?
    // convert from img.Image to ui.Image
    // https://medium.com/@ys.commerciale/process-and-show-an-image-in-flutter-aebb0054ce94

    if (kIsWeb) {
      WidgetsFlutterBinding.ensureInitialized();
      var image = AssetImage(assetFilename);
      var key = await image.obtainKey(ImageConfiguration.empty);
      var stream = image.loadBuffer(
        key,

        PaintingBinding.instance.instantiateImageCodecFromBuffer,
      );
      var completer = Completer<ui.Image>();
      stream.addListener(
        ImageStreamListener((image, synchronousCall) {
          completer.complete(image.image);
        }),
      );
      return completer.future;
    }
    var buffer = await ImmutableBuffer.fromAsset(assetFilename);
    var codec = await ui.instantiateImageCodecFromBuffer(buffer);
    var frame = await codec.getNextFrame();
    return frame.image;
    // ImmutableBuffer immutableBuffer = await ImmutableBuffer.fromAsset(
    //   assetFilename,
    // );
    // ui.Codec codec = await ui.instantiateImageCodecFromBuffer(immutableBuffer);
    // ui.FrameInfo frameInfo = await codec.getNextFrame();
    // return frameInfo.image;
  }

  void initSpriteFromLoadedImage(ui.Image image) {
    print("in initSpriteFromLoadedImage");
    Sprite sprite = Sprite(image, 0, 0, 50, 50, 0, 0, 50, 50);
    mapSymbolToImage[symbolImageBoomerang] = image;
    listSprite.add(sprite);
  }

  bool isLoaded() {
    print(
      "size =$size && listSprite.length =${listSprite.length} && listAssetFilename =${listAssetFilename.length}",
    );
    return (size != null && listSprite.length == listAssetFilename.length);
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
}
