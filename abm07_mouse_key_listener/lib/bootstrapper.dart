import 'package:abm07_mouse_key_listener/gamestate.dart' show GameState;
import 'package:abm07_mouse_key_listener/inputcontroller.dart' show InputController;

class BootStrapper {
  // 1. define router

  // 2. load controllers
  AssetController assetController =AssetController();
  GameState gameState =GameState.instance;
  InputController inputController = InputController.instance;
  inputController.setGameState( gameState );
  inputController.useDefaultMapping();
}
