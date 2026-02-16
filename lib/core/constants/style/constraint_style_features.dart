import 'package:get/get.dart';

class ConstraintStyleFeatures {
  static const double cardPaddingRatio = 0.05;
  static const double cardTitleFontSizeRatio = 0.06;
  static const double cardSmallTitleFontSizeRatio = 0.09;
  static const double cardSubtitleFontSizeRatio = 0.06;
  static const double cardVerticalSpacingRatio = 0.02;
  static const double spaceBetweenElements = 20;

  static double appBarLogoSize(double availableWidth) {

    return availableWidth * 0.15;
  }

  static double gridsPadding () {
    final double screenWidth = Get.mediaQuery.size.width;
    return screenWidth <= 653000 ? 10 : 100;
  }

  static double appBarFontSize(double availableWidth) {
    return availableWidth * 0.03;
  }

  static double appBarPaddingValue(double availableWidth) {
    return availableWidth * 0.05;
  }

  double mostUsedButtonValue(double screenSpace, String constraint) {
    if (constraint == 'H') {
      screenSpace = screenSpace <= 547184 ? 30 : 50;
    } else if (constraint == 'W') {
      screenSpace = screenSpace <= 547184 ? 175 : 250;
    }
    return screenSpace;
  }
}
