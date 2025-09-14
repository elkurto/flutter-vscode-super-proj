import 'package:abm07_mouse_key_listener/assetcontroller.dart' show AssetController;

class Level {
  List<Symbol> listSymbolImage = [];

  void loadImages() {
    AssetController.instance.loadListSymbolImage(listSymbolImage);
  }

  void addSymbolImage(Symbol symbol) {
    listSymbolImage.add(symbol);
  }
}
