import 'package:flutter/material.dart';

class SizeConfig {
  static double screenHeightTarget = 720;
  static double screenWidthTarget = 360;

  static double screenHeight = 0;
  static double screenWidth = 0;

  static Orientation _orientation;

  static init(BuildContext context) {
    if (_orientation != MediaQuery.of(context).orientation &&
        _orientation != null) {
      return;
    }
    _orientation = MediaQuery.of(context).orientation;
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
  }

  static double getPixel(double pixel) {
    return (screenWidth / screenWidthTarget) * pixel;
  }
}
