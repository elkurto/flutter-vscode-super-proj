import 'dart:ui';

import 'package:abm08_mouse_key_listener/assetcontroller.dart' show AssetController;
import 'package:abm08_mouse_key_listener/sprite.dart' show Sprite;
import 'package:abm08_mouse_key_listener/symboldefn.dart';
import 'package:abm08_mouse_key_listener/gamestate.dart' show GameState;

class Level {
  Map<Symbol, Sprite> mapSymbolToSpritePrototype = {};
  bool bIsLoaded = false;
  List<Sprite> listEM = [];

  void initState() {
    loadImages();
  }

  void loadImages() {
    AssetController.instance.loadImageAssets(mapSymbolToSpritePrototype);
  }

  bool isLoaded() {
    if (!bIsLoaded) {
      bool bTempIsAllLoaded = true;
      for (Sprite spritePrototype in mapSymbolToSpritePrototype.values) {
        print("spritePrototype.image =${spritePrototype.image}");
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

  void addSpriteAtLocalOffset(Symbol symbolOfSprite, Offset offset) {
    Sprite? spriteProto = mapSymbolToSpritePrototype[symbolOfSprite];
    if (spriteProto != null && spriteProto.image != null) {
      //(spriteProto.isLoaded()) {

      Sprite sprite = spriteProto.duplicate();
      sprite.update(dx: offset.dx, dy: offset.dy);
      print("sprite dx,dy =${sprite.dx},${sprite.dy}");
      listEM.add(sprite);
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
