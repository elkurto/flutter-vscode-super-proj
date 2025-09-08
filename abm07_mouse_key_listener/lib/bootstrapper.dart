class BootStrapper {
  // 1. define router

  // 2. load controllers
  AssetController assetController =AssetController();
  GameState gameState =GameState.instance;
  InputController inputController = InputController.instance;
  inputController.setGameState( gameState );
  inputController.useDefaultMapping();
}
