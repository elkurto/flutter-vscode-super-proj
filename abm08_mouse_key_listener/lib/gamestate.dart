import 'package:abm08_mouse_key_listener/assetcontroller.dart';
import 'package:abm08_mouse_key_listener/inputcontroller.dart' show InputController;
import 'package:abm08_mouse_key_listener/level.dart' show Level, Level000;
import 'package:abm08_mouse_key_listener/symboldefn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final int DT_DEFAULT = 20;

class GameState {
  GameState._internal();
  static final GameState _instance = GameState._internal();
  static GameState get instance => _instance;

  Size? size;
  int? prevEpochMillis;
  int dt = DT_DEFAULT;
  bool bRunning = true;

  AssetController assetController = AssetController.instance;
  InputController inputController = InputController();
  Level level = Level000();

  int nImageLoaded = 0;

  void initState() {
    level.initState(); // load images, load sound, init input controller
    initMappingInputToFn();
  }

  bool isLoaded() {
    return (size != null && level.isLoaded());
  }

  void initMappingInputToFn() {
    KeyMapperDefault keyMapperDefault = KeyMapperDefault();
    keyMapperDefault.apply(this, inputController);
  }

  void act() {
    if (isLoaded() && bRunning) {
      if (prevEpochMillis == null) {
        prevEpochMillis = DateTime.now().millisecondsSinceEpoch;
        dt = DT_DEFAULT;
      } else {
        int nowEpochMillis = DateTime.now().millisecondsSinceEpoch;
        dt = nowEpochMillis - prevEpochMillis!;
        level.act(this);
        prevEpochMillis = nowEpochMillis;
      }
    }
  }

  void draw(Canvas canvas) {
    if (isLoaded()) {
      level.draw(this, canvas);
    }
  }

  void dispose() {
    level.dispose();
  }

  void addSpriteBoomerangAtLocalOffset(Offset offset) {
    level.addSpriteAtLocalOffset(symbolBoomerang, offset);
  }

  void togglePause(KeyEvent keyEvent) {
    bRunning = !bRunning;
    if (!bRunning) {
      prevEpochMillis = null;
    }
  }

  bool bRequestFirePrimary = false;
  void requestFirePrimary(KeyEvent keyEvent) {
    bRequestFirePrimary = true;
  }

  void requestFirePrimaryTap(TapDownDetails tapDownDetails) {
    // @todo sort out the device kind api
    //- https://api.flutter.dev/flutter/dart-ui/PointerDeviceKind.html
    //- https://api.flutter.dev/flutter/gestures/TapDownDetails/TapDownDetails.html
    //- inputController.registerListenerOfTapDownDetails(gameState.requestFireTertiaryTap);
    bRequestFirePrimary = true;
    level.addSpriteAtLocalOffset(symbolBoomerang, tapDownDetails.localPosition);
  }

  bool bRequestFireSecondary = false;
  void requestFireSecondary(KeyEvent keyEvent) {
    bRequestFireSecondary = true;
  }

  Offset offsetMouse = Offset.zero;
  void updateOffsetMouse(PointerHoverEvent pointerHoverEvent) {
    if (offsetMouse.dx != pointerHoverEvent.localPosition.dx ||
        offsetMouse.dy != pointerHoverEvent.localPosition.dy) {
      print("pointerHoverEvent.localPosition =${pointerHoverEvent.localPosition.toString()}");
    }
    offsetMouse = pointerHoverEvent.localPosition;
  }
}

class KeyMapperDefault {
  void apply(GameState gameState, InputController inputController) {
    print("in KeyMapperDefault::apply");
    // pause
    inputController.registerListenerOfKeyDownEvent(LogicalKeyboardKey.keyP, gameState.togglePause);

    // shiftLeft = fireFirePrimary
    inputController.registerListenerOfKeyDownEvent(
      LogicalKeyboardKey.shiftLeft,
      gameState.requestFirePrimary,
    );

    // rightRight == requestFireSecondary
    inputController.registerListenerOfKeyDownEvent(
      LogicalKeyboardKey.shiftRight,
      gameState.requestFireSecondary,
    );

    // tapDownDetails == [button01], then requestPrimaryFire
    // tapDownDetails == [button03], then requestSecondaryFire
    inputController.registerListenerOfTapDownDetails(gameState.requestFirePrimaryTap);
    // todo handle secondary and tertiary taps.

    inputController.registerListenerOfPointerHoverEvent(gameState.updateOffsetMouse);
  }
}
