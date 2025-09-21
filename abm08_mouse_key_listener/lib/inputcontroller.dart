import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

interface class InputController {
  Map<LogicalKeyboardKey, void Function(KeyEvent)> mapFnKeyDownEvent = {};
  Map<LogicalKeyboardKey, void Function(KeyEvent)> mapFnKeyUpEvent = {};

  List<void Function(PointerHoverEvent)> listFnPositionHoverEvent = [];
  List<void Function(TapDownDetails)> listFnTapDownDetails = [];
  List<void Function(TapUpDetails)> listFnTapUpDetails = [];

  void registerListenerOfKeyDownEvent(
    LogicalKeyboardKey logicalKeyboardKey,
    void Function(KeyEvent) handler,
  ) {
    mapFnKeyDownEvent[logicalKeyboardKey] = handler;
  }

  void registerListenerOfKeyUpEvent(
    LogicalKeyboardKey logicalKeyboardKey,
    void Function(KeyEvent) handler,
  ) {
    mapFnKeyDownEvent[logicalKeyboardKey] = handler;
  }

  void registerListenerOfPointerHoverEvent(void Function(PointerHoverEvent) fnHandler) {
    listFnPositionHoverEvent.add(fnHandler);
  }

  void registerListenerOfTapDownDetails(void Function(TapDownDetails) fnHandler) {
    listFnTapDownDetails.add(fnHandler);
  }

  void registerListenerOfTapUpDetails(void Function(TapUpDetails) fnHandler) {
    listFnTapUpDetails.add(fnHandler);
  }

  void unregisterListenerOfKeyDownEvent(LogicalKeyboardKey logicalKeyboardKey) {
    mapFnKeyDownEvent.remove(logicalKeyboardKey);
  }

  void unregisterListenerOfKeyUpEvent(LogicalKeyboardKey logicalKeyboardKey) {
    mapFnKeyDownEvent.remove(logicalKeyboardKey);
  }

  void unregisterListenerOfPointerHoverEvent(void Function(PointerHoverEvent) fnHandler) {
    listFnPositionHoverEvent.remove(fnHandler);
  }

  void unregisterListenerOfTapDownDetails(void Function(TapDownDetails) fnHandler) {
    listFnTapDownDetails.remove(fnHandler);
  }

  void unregisterListenerOfTapUpDetails(void Function(TapUpDetails) fnHandler) {
    listFnTapUpDetails.remove(fnHandler);
  }

  void handleKeyEvent(KeyEvent keyEvent) {
    if (keyEvent is KeyDownEvent) {
      handleKeyDownEvent(keyEvent);
    } else if (keyEvent is KeyUpEvent) {
      handleKeyUpEvent(keyEvent);
    }
  }

  void handleKeyDownEvent(KeyEvent keyEvent) {
    var handler = mapFnKeyDownEvent[keyEvent.logicalKey];
    if (handler != null) {
      handler(keyEvent);
    }
  }

  void handleKeyUpEvent(KeyEvent keyEvent) {
    var handler = mapFnKeyUpEvent[keyEvent.logicalKey];
    if (handler != null) {
      handler(keyEvent);
    }
  }

  void handlePointerHoverEvent(PointerHoverEvent pointerHoverEvent) {
    for (var handler in listFnPositionHoverEvent) {
      handler(pointerHoverEvent);
    }
  }

  void handleTapDownEvent(TapDownDetails tapDownDetails) {
    print("in handleTapDownEvent :::: ${tapDownDetails.localPosition}");
    for (var handler in listFnTapDownDetails) {
      handler(tapDownDetails);
    }
  }

  void handleTapUpEvent(TapUpDetails tapUpDetails) {
    for (var handler in listFnTapUpDetails) {
      handler(tapUpDetails);
    }
  }
}

class InputControllerSingleton extends InputController {
  // 1. private named constructor
  InputControllerSingleton._internal();
  // 2. static final field that refers to the singleton instance
  static final InputControllerSingleton _instance = InputControllerSingleton._internal();
  // 3. static getter to allow clients to retreive instance
  static InputControllerSingleton get instance => _instance;
}
