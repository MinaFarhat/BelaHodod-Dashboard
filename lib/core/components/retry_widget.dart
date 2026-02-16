import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constants/style/color_style_features.dart';

class RetryWidget extends StatelessWidget {
  const RetryWidget({super.key, required this.error, required this.func});
  final String error;
  final Function func;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(error,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: ColorStyleFeatures.headLinesTextColor,
            )),
        SizedBox(
          height: 2.h,
        ),
        InkWell(
          onTap: () => func(),
          child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: ColorStyleFeatures.headLinesTextColor,
              ),
              child: const Center(
                child: Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
              )), //............
        ),
      ],
    ));
  }
}
