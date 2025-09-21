import 'dart:math';
import 'dart:ui' as ui;
import 'package:abm08_mouse_key_listener/gamestate.dart' show GameState;
import 'package:flutter/material.dart';

class Sprite {
  String assetPath;
  ui.Image? image;
  double sx = 0.0;
  double sy = 0.0;
  double sw = 50.0;
  double sh = 50.0;
  double dx = 100.0;
  double dy = 100.0;
  double dw = 50.0;
  double dh = 50.0;
  final Paint paintBackground = Paint()..color = Color(0xAA000000);
  double vx = 5.0 / 1000.0;
  double vy = 5.0 / 1000.0;
  double theta = 45.0 * pi / 180.0;
  double vtheta = 2.5 / 1000.0;

  void update({
    double? sx,
    double? sy,
    double? sw,
    double? sh,
    double? dx,
    double? dy,
    double? dw,
    double? dh,
    double? vx,
    double? vy,
    double? theta,
    double? vtheta,
  }) {
    if (sx != null) {
      this.sx = sx;
    }
    if (sy != null) {
      this.sy = sy;
    }
    if (sw != null) {
      this.sw = sw;
    }
    if (sh != null) {
      this.sh = sh;
    }
    if (dx != null) {
      this.dx = dx;
    }
    if (dy != null) {
      this.dy = dy;
    }
    if (dw != null) {
      this.dw = dw;
    }
    if (dh != null) {
      this.dh = dh;
    }
    if (theta != null) {
      this.theta = theta;
    }
    if (vtheta != null) {
      this.vtheta = vtheta;
    }
  }

  Sprite(this.assetPath);

  void act(GameState gameState) {
    dx = gameState.dt * vx + dx;
    dy = gameState.dt * vy + dy;
    if (dx < 0 || gameState.size!.width < dx || dy < 0 || gameState.size!.height < dy) {
      dx = gameState.size!.width / 2;
      dy = gameState.size!.height / 2;
    }
    theta = theta + vtheta * gameState.dt;
  }

  void draw(GameState gameState, Canvas canvas) {
    //// Extrapolated from code comments in source code
    ////   https://github.com/flutter/engine/blob/main/lib/ui/painting.dart#L5951
    ///

    // rotate clockwise (forward/ positive)
    var rSTransform = RSTransform.fromComponents(
      rotation: theta,
      scale: 1,
      // Center of the sprite relative to its rect
      anchorX: sw / 2, // center-of-rotation of sprite-space
      anchorY: sh / 2,
      // Location at which to draw the center of the sprite
      translateX: dx + sw / 2,
      translateY: dy + sw / 2,
    );

    // rotate counter-clockwise (backward/ negative)
    var rSTransformCCW = RSTransform.fromComponents(
      rotation: -1 * theta,
      scale: 1.5,
      // Center of the sprite relative to its rect
      anchorX: sw / 2, // center-of-rotation of sprite-space
      anchorY: sh / 2,
      // Location at which to draw the center of the sprite in viewport-space
      translateX: dx + sw / 2,
      translateY: dy + sw / 2,
    );

    if (image != null) {
      canvas.save();

      canvas.drawAtlas(
        image!,
        <RSTransform>[rSTransform, rSTransformCCW],
        <Rect>[Rect.fromLTWH(0, 0, 50, 50), Rect.fromLTWH(0, 0, 50, 50)], // src rect in image_space
        null,
        null,
        null,
        paintBackground,
      );

      canvas.restore();
    }
  }

  Sprite duplicate() {
    var dup = Sprite(this.assetPath);
    dup.image = this.image;
    dup.update(
      sx: sx,
      sy: sy,
      sw: sw,
      sh: sh,
      dx: dx,
      dy: dy,
      dw: dw,
      dh: dh,
      vx: vx,
      vy: vy,
      theta: theta,
      vtheta: vtheta,
    );
    return dup;
  }
}
