import 'package:abm07_mouse_key_listener/assetcontroller.dart' show AssetController;
import 'package:abm07_mouse_key_listener/sprite.dart' show Sprite;

class Level {
  Map<Symbol, Sprite> mapSymbolToSprite = {};

  void loadImages() {
    AssetController.instance.loadImageAssets(mapSymbolToSprite);
  }
}
