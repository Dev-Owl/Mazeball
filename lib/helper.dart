import 'dart:ui';
import 'package:box2d_flame/box2d.dart';

/// Simple convert a none null Offset to a Vector2
Vector2 offsetToVector2(Offset value) {
  if (value == null) throw new ArgumentError.notNull("value");
  return Vector2(value.dx, value.dy);
}
/// Scale (divide) both values of a none null Vector2 by a given value
Vector2 scaleVectoreBy(Vector2 value, double scale) {
  if (value == null) throw new ArgumentError.notNull("value");
  return Vector2(value.x / scale, value.y / scale);
}
//create a new scaled size by a given factor 
Size scaleSizeBy(Size value, double scale){
  if (value == null) throw new ArgumentError.notNull("value");
  return Size(value.width /scale, value.height/scale);
}
