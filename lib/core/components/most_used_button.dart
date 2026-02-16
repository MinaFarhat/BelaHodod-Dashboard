import 'package:flutter/material.dart';
import '../constants/style/color_style_features.dart';
import '../constants/style/constraint_style_features.dart';
import '../constants/style/text_style_features.dart';

class MostUsedButton extends StatelessWidget {
  final String buttonText;
  final IconData? buttonIcon;
  final Function onTap;

  const MostUsedButton({
    super.key,
    required this.buttonText,
    this.buttonIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    ConstraintStyleFeatures constraintStyleFeatures = ConstraintStyleFeatures();

    final Size screenSize = MediaQuery.of(context).size;
    final double screenSpace = screenSize.height * screenSize.width;
    return SizedBox(
      width: constraintStyleFeatures.mostUsedButtonValue(screenSpace, 'W'),
      height: constraintStyleFeatures.mostUsedButtonValue(screenSpace, 'H'),
      child: ElevatedButton(
        onPressed: () async {
          onTap();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorStyleFeatures.mostUsedButtonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // Align children in the center vertically
          children: [
            Text(
              buttonText,
              style: TextStyleFeatures.mostUsedButtonTextStyle(screenSpace),
              textDirection: TextDirection
                  .rtl, // Set text direction to right-to-left for Arabic
            ),
            const SizedBox(width: 8), // Add spacing between text and icon
            Icon(
              buttonIcon,
              color: ColorStyleFeatures.inButtonsTextColor,
            ),
          ],
        ),
      ),
    );
  }
}
