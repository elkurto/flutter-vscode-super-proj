import 'dart:ui';

import 'package:abm07_mouse_key_listener/assetcontroller.dart' show AssetController;
import 'package:abm07_mouse_key_listener/sprite.dart' show Sprite;
import 'package:abm07_mouse_key_listener/symboldefn.dart';
import 'package:abm07_mouse_key_listener/gamestate.dart' show GameState;

class Level {
  Map<Symbol, Sprite> mapSymbolToSpritePrototype = {};
  bool bIsLoaded = false;
  List<Sprite> listEM = [];

  void loadImages() {
    AssetController.instance.loadImageAssets(mapSymbolToSpritePrototype);
  }

  bool isLoaded() {
    if (!bIsLoaded) {
      bool bTempIsAllLoaded = true;
      for (Sprite spritePrototype in mapSymbolToSpritePrototype.values) {
        if (spritePrototype.image == null) {
          bTempIsAllLoaded = false;
          break;
        }
      }
      bIsLoaded = bTempIsAllLoaded;
    }

    return bIsLoaded;
  }

  void dispose() {
    for (Sprite sprite in mapSymbolToSpritePrototype.values) {
      if (sprite.image != null) {
        sprite.image!.dispose();
      }
    }
  }

  void act(GameState gameState) {
    for (Sprite em in listEM) {
      em.act(gameState);
    }
  }

  void draw(GameState gameState, Canvas canvas) {
    for (Sprite em in listEM) {
      em.draw(gameState, canvas);
    }
  }
}

class Level000 extends Level {
  Level000() {
    _initMapSymbolToSpritePrototype();
  }

  void _initMapSymbolToSpritePrototype() {
    Sprite spriteBoomerangPrototype = Sprite("assets/boomerang.000.50x50.png");
    spriteBoomerangPrototype.update(sx: 125, sy: 100);
    super.mapSymbolToSpritePrototype[symbolBoomerang] = spriteBoomerangPrototype;
  }
}
