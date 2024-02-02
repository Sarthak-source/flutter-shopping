import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenUtils {
  static double? screenWidth;
  static double? screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    screenWidth = Get.width;
    screenHeight = Get.height;
    orientation = Get.mediaQuery.orientation;
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = ScreenUtils.screenHeight!;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = ScreenUtils.screenWidth!;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}
