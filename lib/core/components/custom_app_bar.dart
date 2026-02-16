// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/style/constraint_style_features.dart';
import '../constants/style/text_style_features.dart';
import '../utils/app_shared_pref.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({super.key});

  final RxBool isHovered1 = false.obs;
  final RxBool isHovered2 = false.obs;
  final RxBool isHovered3 = false.obs;
  double availableWidth = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: SizedBox(
        height: 100,
        child: LayoutBuilder(
          builder: (context, constraints) {
            availableWidth = constraints.maxWidth;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: ConstraintStyleFeatures.appBarPaddingValue(
                        availableWidth)),
                Expanded(
                  child: buildNavItem('الرئيسية', isHovered1,
                      ConstraintStyleFeatures.appBarFontSize(availableWidth),
                      () {
                    Get.offAllNamed("/home_screen");
                  }),
                ),
                Expanded(
                  child: buildNavItem('التقارير', isHovered2,
                      ConstraintStyleFeatures.appBarFontSize(availableWidth),
                      () {
                    Get.offAllNamed("/reports_screen");
                  }),
                ),
                Expanded(
                  child: buildNavItem(
                      'تسجيل الخروج',
                      isHovered3,
                      ConstraintStyleFeatures.appBarFontSize(availableWidth) /
                          1.02, () {
                    AppSharedPref appSharedPref = AppSharedPref();
                    appSharedPref.deleteAll();
                    Get.offAllNamed("/login");
                  }),
                ),
                const Spacer(),
                SizedBox(
                    width: ConstraintStyleFeatures.appBarPaddingValue(
                        availableWidth)),
                SizedBox(
                  width: ConstraintStyleFeatures.appBarLogoSize(availableWidth),
                  height:
                      ConstraintStyleFeatures.appBarLogoSize(availableWidth),
                  child: GestureDetector(
                    onTap: () {
                      // Handle logo tap
                    },
                    child: const LogoImage(),
                  ),
                ),
                SizedBox(
                    width: ConstraintStyleFeatures.appBarPaddingValue(
                        availableWidth)),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildNavItem(
      String text, RxBool isHovered, double fontSize, Function onTap) {
    return Obx(
      () => MouseRegion(
        onEnter: (_) => isHovered.value = true,
        onExit: (_) => isHovered.value = false,
        cursor: isHovered.value
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        child: GestureDetector(
          onTap: () {
            onTap();
          },
          child: Text(
            text,
            style: TextStyleFeatures.appBarTextStyle(
                availableWidth, isHovered.value),
          ),
        ),
      ),
    );
  }
}
