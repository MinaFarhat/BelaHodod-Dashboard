import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'color_style_features.dart';
import 'constraint_style_features.dart';

class TextStyleFeatures {
  late BoxConstraints? constraints;
  static const String fontFamily = 'Arial';
  late double size = constraints!.maxWidth * constraints!.maxHeight;
TextStyleFeatures.textStyleFeaturesWithConstraints (this.constraints);
TextStyleFeatures();

   TextStyle generalTextStyleWithConstraints (){
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: size * 0.00003,
      fontWeight: FontWeight.bold,
      color: ColorStyleFeatures.generalTextColor,
    );
  }
  TextStyle generalTextStyleWithConstraints1 (BoxConstraints? constraints){
    double size = constraints!.maxWidth * constraints.maxHeight;
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: size * 0.00003,
      fontWeight: FontWeight.bold,
      color: ColorStyleFeatures.generalTextColor,
    );
  }
  static TextStyle generalTextStyle = TextStyle(
    fontFamily: fontFamily,
    fontSize:Get.mediaQuery.size.width * 0.02,
   fontWeight: FontWeight.bold,
    color: ColorStyleFeatures.generalTextColor,
  );

  static TextStyle headLinesTextStyle = TextStyle(
    fontFamily: fontFamily,
    fontSize: Get.mediaQuery.size.width * 0.03,
    fontWeight: FontWeight.bold,
    color: ColorStyleFeatures.headLinesTextColor,
  );

  static TextStyle mostUsedButtonTextStyle(double screenSpace) {
    return TextStyle(
      fontSize: screenSpace <= 547184 ? 13 : 18,
      fontWeight: FontWeight.bold,
      fontFamily: fontFamily,
      color: ColorStyleFeatures
          .inButtonsTextColor, // Use appropriate Arabic font family
    );
  }

  static const TextStyle sideBarTextStyle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 25,
    fontWeight: FontWeight.bold,
    color: ColorStyleFeatures.dropdownChoiceTextColor,
  );

  static TextStyle appBarTextStyle(double maxWidth, bool isHovered) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: maxWidth * 0.025,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline,
      decorationColor:
          isHovered ? ColorStyleFeatures.onHoverColor : Colors.transparent,
      color: isHovered ? ColorStyleFeatures.onHoverColor : Colors.black,
      decorationThickness: 0.5,
    );
  }

  TextStyle cardTitleTextStyle(double availableWidth, bool title) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: availableWidth >= 260
          ? availableWidth * ConstraintStyleFeatures.cardTitleFontSizeRatio
          : availableWidth *
              ConstraintStyleFeatures.cardSmallTitleFontSizeRatio,
      fontWeight: FontWeight.bold,
      color: title == true ? Colors.black : Colors.black54,
    );
  }

  TextStyle dropdownNameTextStyle(bool isExpanded) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 25,
      fontWeight: FontWeight.bold,
      color: isExpanded
          ? ColorStyleFeatures.onHoverColor
          : ColorStyleFeatures.dropdownChoiceTextColor,
    );
  }
}

class LogoImage extends StatelessWidget {
  const LogoImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'web/icons/logo.jfif',
      fit: BoxFit.contain,
    );
  }
}
class LogInImage extends StatelessWidget {
  const LogInImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'web/icons/logo.jfif',
      fit: BoxFit.contain,
    );
  }
}