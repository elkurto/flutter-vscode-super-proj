// 1. Singleton
// 2. listen for keyboard input ??? (need a widget) make this a widget with a stateful singleton
// 3.

class InputControllerSingleton {
  // i have the state
  bool firePrimaryPressed = false;
  bool fireSecondaryPressed = false;
  bool pausePressed = false;

  // 1. private named constructor
  //
  InputControllerSingleton._internal();

  // 2. static final field that refers to the singleton instance
  static final InputControllerSingleton _instance =
      InputControllerSingleton._internal();

  // 3. static getter to allow clients to retreive instance
  static InputControllerSingleton get instance => _instance;
}
