import 'dart:async';
import 'dart:collection';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:abm07_mouse_key_listener/assetcontroller.dart';
import 'package:abm07_mouse_key_listener/inputcontroller.dart' show InputController;
import 'package:abm07_mouse_key_listener/level.dart' show Level, Level000;
import 'package:abm07_mouse_key_listener/sprite.dart' show Sprite;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GameState {
  GameState._internal();
  static final GameState _instance = GameState._internal();
  static GameState get instance => _instance;

  Size? size;
  int? prevEpochMillis;
  int dt = 20;

  AssetController assetController = AssetController.instance;
  Level level = Level000();

  //final Map<Symbol, ui.Image> mapSymbolToImage = HashMap();
  final List<Sprite> listSprite = [];
  //final List<String> listAssetFilename = ["assets/boomerang.000.50x50.png"];
  int nImageLoaded = 0;

  // void loadImageAssets() {
  //   print("in loadImageAssets");
  //   Future<ui.Image> futureUiImage = loadImageAsync(listAssetFilename[0]);

  //   futureUiImage.then(initSpriteFromLoadedImage);
  // }

  // Future<ui.Image> loadImageAsync(String assetFilename) async {
  //   print("in loadImageAsync");

  //   // this block works 100%
  //   ImmutableBuffer immutableBuffer = await rootBundle.loadBuffer(assetFilename);
  //   var codec = await ui.instantiateImageCodecFromBuffer(immutableBuffer);
  //   var frame = await codec.getNextFrame();
  //   return frame.image;
  // }

  // void initSpriteFromLoadedImage(ui.Image image) {
  //   print("in initSpriteFromLoadedImage");
  //   nImageLoaded += 1;
  //   mapSymbolToImage[symbolImageBoomerang] = image;

  //   Sprite sprite = Sprite(image, 0, 0, 50, 50, 100, 100, 50, 50);
  //   listSprite.add(sprite);

  //   Sprite sprite2 = Sprite(image, 0, 0, 50, 50, 200, 100, 50, 50);
  //   listSprite.add(sprite2);
  // }

  void initState() {
    level.loadImages();
  }

  bool isLoaded() {
    // print(
    //   "size =$size && listSprite.length =${listSprite.length} && listAssetFilename =${listAssetFilename.length}",
    // );
    return (size != null && level.isLoaded());
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
    // for (var key in mapSymbolToImage.keys) {
    //   ui.Image? uiImage = mapSymbolToImage[key];
    //   if (uiImage != null) {
    //     uiImage.dispose();
    //   }
    // }
    level.dispose();
  }

  void addSpriteAtLocalOffset(Offset offset) {
    ui.Image? image = mapSymbolToImage[symbolImageBoomerang];
    if (image != null) {
      Sprite sprite = Sprite(image, 0, 0, 50, 50, offset.dx - 50 / 2, offset.dy - 50 / 2, 50, 50);
      listSprite.add(sprite);
    }
  }

  bool bPause = false;
  void togglePause(KeyEvent keyEvent) {
    bPause = !bPause;
  }

  bool bRequestFirePrimary = false;
  void requestFirePrimary(KeyEvent keyEvent) {
    bRequestFirePrimary = true;
  }

  void requestFirePrimaryTap(TapDownDetails tapDownDetails) {
    // @todo sort out the device kind api
    //- https://api.flutter.dev/flutter/dart-ui/PointerDeviceKind.html
    //- https://api.flutter.dev/flutter/gestures/TapDownDetails/TapDownDetails.html
    //- inputController.registerListenerOfTapDownDetails(gameState.requestFireTertiaryTap);
    bRequestFirePrimary = true;
  }

  bool bRequestFireSecondary = false;
  void requestFireSecondary(KeyEvent keyEvent) {
    bRequestFireSecondary = true;
  }
}

class KeyMapperDefault {
  void apply(GameState gameState, InputController inputController) {
    // pause
    inputController.registerListenerOfKeyDownEvent(LogicalKeyboardKey.keyP, gameState.togglePause);

    // shiftLeft = fireFirePrimary
    inputController.registerListenerOfKeyDownEvent(
      LogicalKeyboardKey.shiftLeft,
      gameState.requestFirePrimary,
    );

    // rightRight == requestFireSecondary
    inputController.registerListenerOfKeyDownEvent(
      LogicalKeyboardKey.shiftRight,
      gameState.requestFireSecondary,
    );

    // tapDownDetails == [button01], then requestPrimaryFire
    // tapDownDetails == [button03], then requestSecondaryFire
    inputController.registerListenerOfTapDownDetails(gameState.requestFirePrimaryTap);
    // todo handle secondary and tertiary taps.
  }
}
