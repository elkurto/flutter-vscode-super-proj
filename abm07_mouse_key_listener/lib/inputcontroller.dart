import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HandlerKeyEvent {
  void call(KeyEvent keyEvent) {
    return; // do nothing
  }
}

class HandlerTapDownDetails {
  void call(TapDownDetails keyEvent) {
    return; // do nothing
  }
}

class HandlerTapUpDetails {
  void call(TapDownDetails keyEvent) {
    return; // do nothing
  }
}

class HandlerMouseMoveEvent {
  void call(PointerHoverEvent pointerHoverEvent) {
    return;
  }
}

class InputController {
  // i have the state
  bool firePrimaryDown = false;
  bool fireSecondaryDown = false;
  bool paused = false;

  // 1. private named constructor
  //
  InputController._internal();

  // 2. static final field that refers to the singleton instance
  static final InputController _instance = InputController._internal();

  // 3. static getter to allow clients to retreive instance
  static InputController get instance => _instance;

  Map<KeyEvent, HandlerKeyEvent> mapKeyEvent = {};
  List<HandlerMouseMoveEvent> listHandlerMouseMove = [];
  List<HandlerTapDownDetails> listHandlerTapDownDetails = [];
  List<HandlerTapUpDetails> listHandlerTapUpDetails = [];

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
