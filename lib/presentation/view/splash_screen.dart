import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/constants/style/text_style_features.dart';
import '../../core/utils/app_shared_pref.dart';

class SplashScreen extends StatelessWidget {
  final AppSharedPref appSharedPref = AppSharedPref();

  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    startTimer();
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 80.h, child: const LogoImage()),
            ],
          ),
        ),
      ),
    ));
  }

  startTimer() {
    Timer(
      const Duration(seconds: 1),
      () {
        if (AppSharedPref().isLogin()) {
          Get.offAndToNamed("/home_screen");
        } else {
          Get.offAndToNamed("/login");
        }
      },
    );
  }
}
