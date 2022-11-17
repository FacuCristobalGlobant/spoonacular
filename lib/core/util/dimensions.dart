import 'package:flutter/material.dart';

abstract class Dimensions {
  static const EdgeInsets smallPadding = EdgeInsets.all(10);
  static const EdgeInsets smallerPadding = EdgeInsets.all(5);
  static const EdgeInsets mediumPadding = EdgeInsets.all(50);
  static const EdgeInsets horizontalPadding = EdgeInsets.symmetric(
    horizontal: 50,
  );
  static const EdgeInsets topPadding = EdgeInsets.only(
    top: 20,
  );
  static const EdgeInsets verticalPadding = EdgeInsets.symmetric(
    vertical: 50,
  );
  static const Offset shadowOffset = Offset(5, 5);
  static const double cardRadius = 5;
  static const double smallScreen = 800;
  static const double bigScreen = 1700;
  static const EdgeInsets safeAreaPadding = EdgeInsets.symmetric(
    vertical: 100,
  );
  static const double bigFontSize = 24;
  static const double recipeImageWidth = 320;
  static const double recipeImageHeight = 180;
  static const double timerOffset = 10;
  static const int summaryAnimationDuration = 200;
  static const int summaryMaxLines = 4;
  static const int minutesInHour = 60;
}
