import 'package:flutter/material.dart';

class SizeConfig {
 static MediaQueryData _mediaQueryData;
 static double screenWidth;
 static double screenHeight;
 static double horizontal;
 static double vertical;
 
 void init(BuildContext context) {
  _mediaQueryData = MediaQuery.of(context);
  screenWidth = _mediaQueryData.size.width;
  screenHeight = _mediaQueryData.size.height;
  horizontal = screenWidth / 100;
  vertical = screenHeight / 100;
 }
}