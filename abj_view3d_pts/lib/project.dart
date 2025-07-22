import 'dart:math' as math;

import 'package:vector_math/vector_math_64.dart';

// Lifted from https://github.com/filiph/observable_flutter_cube/tree/main/lib/renderer
// in an attempt to understand projection matrices.
// Also go watch - Faking 3d graphics in flutter - https://www.youtube.com/watch?v=DmId-KOgPkg
//  Filip Hracek - "Faking 3D in Flutter — pair programming with Craig Labenz"
//
// additional reference
//  src =https://github.com/google/vector_math.dart/blob/master/lib/src/vector_math_64/opengl.dart
Vector2 project(Vector3 point, double rotation, double aspectRatio) {
  final viewMatrix = makeViewMatrix(
    Vector3(math.cos(rotation), 0.25, math.sin(rotation)) * 2,
    Vector3.all(0.5),
    Vector3(0, 1, 0),
  );

  // final viewMatrix = makeViewMatrix(
  //   // this works
  //   Vector3(2, 0, .1), // 2,0,0.1 okay // exception when 0,0,0
  //   Vector3.all(0.5),
  //   Vector3(0, 1, 0),
  // );
  const near = 1.0;
  const fov = 60.0;
  const zoom = 1.0;
  final double top = near * math.tan(radians(fov) / 2.0) / zoom;
  final double bottom = -top;
  final double right = top * aspectRatio;
  final double left = -right;
  const double far = 1000.0;

  final projectionMatrix = makeFrustumMatrix(
    left,
    right,
    bottom,
    top,
    near,
    far,
  );

  final transformationMatrix = projectionMatrix * viewMatrix;

  final projectiveCoords = Vector4(point.x, point.y, point.z, 1.0);
  projectiveCoords.applyMatrix4(transformationMatrix);

  var x = projectiveCoords.x / projectiveCoords.w;
  var y = projectiveCoords.y / projectiveCoords.w;

  return Vector2(x, y);
}
