import 'dart:ui' as ui;
import 'package:abm07_mouse_key_listener/sprite.dart' show Sprite;
import 'package:flutter/services.dart';
import 'dart:collection';
import 'dart:async';

class AssetController {
  AssetController.internal();

  static final AssetController _instance = AssetController.internal();

  static AssetController get instance => _instance;

  Map<Symbol, ui.Image> mapSymbolImage = {};

  void loadImageAssets(Map<Symbol, Sprite> mapSymbolToAssetPathOfImage) {
    for (Symbol symbol in mapSymbolToAssetPathOfImage.keys) {
      Sprite? sprite = mapSymbolToAssetPathOfImage[symbol];

      if (sprite != null) {
        String assetPath = sprite.assetPath;
        Future<ui.Image> futureUiImage = loadImageAsync(assetPath);

        futureUiImage.then(initSpriteFromLoadedImage);
      }
    }
  }

  Future<ui.Image> loadImageAsync(String assetFilename) async {
    print("in loadImageAsync");

    // load an image and return a future
    ImmutableBuffer immutableBuffer = await rootBundle.loadBuffer(assetFilename);
    var codec = await ui.instantiateImageCodecFromBuffer(immutableBuffer);
    var frame = await codec.getNextFrame();
    return frame.image;
  }

  void initSpriteFromLoadedImage(ui.Image image) {}
}
