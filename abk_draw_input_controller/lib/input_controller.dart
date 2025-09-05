// 1. Singleton
// 2. listen for keyboard input ??? (need a widget) make this a widget with a stateful singleton
// 3.

import 'package:flutter/services.dart';

class InputControllerSingleton {
  // i have the state
  bool firePrimaryDown = false;
  bool fireSecondaryDown = false;
  bool paused = false;

  // 1. private named constructor
  //
  InputControllerSingleton._internal();

  // 2. static final field that refers to the singleton instance
  static final InputControllerSingleton _instance =
      InputControllerSingleton._internal();

  // 3. static getter to allow clients to retreive instance
  static InputControllerSingleton get instance => _instance;

  void handleKeyEvent(KeyEvent keyEvent) {
    bool bIsKeyDown = (keyEvent is KeyDownEvent);
    switch (keyEvent.logicalKey) {
      case LogicalKeyboardKey.space:
        firePrimaryDown = bIsKeyDown;
        break;
      case LogicalKeyboardKey.shift:
        fireSecondaryDown = bIsKeyDown;
        break;
      case LogicalKeyboardKey.keyP:
        paused = !paused;
        break;
      default:
        print("no match");
    }
  }
}

class InputController {
  static void handleKeyEvent(KeyEvent keyEvent) {
    InputControllerSingleton.instance.handleKeyEvent(keyEvent);
  }
}
