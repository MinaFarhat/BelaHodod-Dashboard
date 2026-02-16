import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomButton extends StatelessWidget {
  final IconData icon;
  final Function onTap;
  final Color backgroundColor;
  final BoxConstraints constraints;

  const CustomButton(
      {super.key,
      required this.icon,
      required this.onTap,
      required this.backgroundColor,
      required this.constraints});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width: 3.5.w,
        height: 3.5.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.px), color: backgroundColor),
        child: Center(
            child: Icon(
          icon,
          size: 28,
          color: Colors.white,
        )),
      ),
    );
  }
}
