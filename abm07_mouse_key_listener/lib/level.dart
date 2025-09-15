import 'package:abm07_mouse_key_listener/assetcontroller.dart' show AssetController;
import 'package:abm07_mouse_key_listener/sprite.dart' show Sprite, new;
import 'package:abm07_mouse_key_listener/symboldefn.dart';

class Level {
  Map<Symbol, Sprite> mapSymbolToSpritePrototype = {};

  void loadImages() {
    AssetController.instance.loadImageAssets(mapSymbolToSpritePrototype);
  }
}

class Level000 extends Level {
  Level000() {
    _initMapSymbolToSpritePrototype();
  }

  void _initMapSymbolToSpritePrototype() {
    Sprite spriteBoomerang =Sprite("assets/boomerang.000.50x50.png");
    spriteBoomerang.update(sx:125, sy:100);
    super.mapSymbolToSpritePrototype[symbolBoomerang] =spriteBoomerang;

  }
}
