import 'dart:async';
import 'dart:collection';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GameState {
  GameState._internal();
  static final GameState _instance = GameState._internal();
  static GameState get instance => _instance;

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
