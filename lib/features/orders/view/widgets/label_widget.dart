import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/constants/style/color_style_features.dart';
import '../../../../core/constants/style/text_style_features.dart';
class LabelWidget extends StatelessWidget {
  final String label;
  final String value;

  const LabelWidget({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            label,
            style:
            TextStyle(
              fontFamily: 'Arial',
              fontSize:Get.mediaQuery.size.width * 0.02,
              fontWeight: FontWeight.bold,
              color: ColorStyleFeatures.dropdownChoicesBackgroundColor,
            ),
          ),
          SizedBox(
            width: 1.w,
          ),
          Text(
            value,
            style:             TextStyleFeatures.generalTextStyle,

          ),
        ],
      ),
    );
  }
}
