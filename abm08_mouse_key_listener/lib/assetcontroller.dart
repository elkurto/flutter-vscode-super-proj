import 'dart:ui' as ui;
import 'package:abm08_mouse_key_listener/sprite.dart' show Sprite;
import 'package:flutter/services.dart';
import 'dart:async';

class AssetController {
  AssetController._internal();

  static final AssetController _instance = AssetController._internal();

  static AssetController get instance => _instance;

  Map<Symbol, ui.Image> mapSymbolImage = {};

  void loadImageAssets(Map<Symbol, Sprite> mapSymbolToSpritePrototype) {
    for (Symbol symbol in mapSymbolToSpritePrototype.keys) {
      Sprite? sprite = mapSymbolToSpritePrototype[symbol];

      if (sprite != null) {
        String assetPath = sprite.assetPath;
        Future<ui.Image> futureUiImage = loadImageAsync(assetPath);

        futureUiImage.then((image) {
          sprite.image = image;
        });
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
}
