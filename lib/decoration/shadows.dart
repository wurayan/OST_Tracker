import 'package:flutter/material.dart';

class Shadows {
  static const shadowSmall = BoxShadow(
      color: Color(0xFF000022),
      blurStyle: BlurStyle.solid,
      offset: Offset(2, 2));

  static const shadowMid = BoxShadow(
      color: Color(0xFF000022),
      blurStyle: BlurStyle.solid,
      offset: Offset(5, 5));

  static const shadowBig = BoxShadow(
      color: Color(0xFF000022),
      blurStyle: BlurStyle.solid,
      offset: Offset(10, 10));
}
