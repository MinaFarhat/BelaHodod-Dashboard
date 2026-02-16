import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constants/style/color_style_features.dart';

class DialogHelper {
  //show error dialog
  static void showErrorDialog(
      {String title = "خطأ", String description = "حدث خطأ ما"}) {
    Get.dialog(Dialog(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title),
          Text(
            description,
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
              onPressed: () {
                if (Get.isDialogOpen!) Get.back();
              },
              child: const Text("تم"))
        ],
      ),
    )));
  }

  //show loading dialog
  static void showLoadingDialog() {
    Get.dialog(Dialog(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          SizedBox(
            height: 2.h,
          ),
          const Text(
            "الرجاء الإنتظار",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ],
      ),
    )));
  }

  //show ask dialog
  static void showAskDialog(String title, String description, Function func) {
    Get.defaultDialog(
        title: title,
        middleText: description,
        titleStyle: const TextStyle(color: Colors.black, fontSize: 16),
        middleTextStyle: const TextStyle(color: Colors.white),
        textConfirm: "تأكيد",
        textCancel: "إلغاء",
        cancelTextColor: ColorStyleFeatures.headLinesTextColor,
        confirmTextColor: Colors.white,
        buttonColor: ColorStyleFeatures.headLinesTextColor,
        onConfirm: () async {
          func();
        },
        barrierDismissible: false,
        radius: 10,
        content: Container());
  }

  //show success dialog
  static void showSuccessDialog(
      {String title = "تم", String description = "تمت العملية بنجاح"}) {
    Get.dialog(Dialog(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
          ),
          Text(
            description,
          ),
          ElevatedButton(
              onPressed: () {
                if (Get.isDialogOpen!) Get.back();
              },
              child: const Text("تم"))
        ],
      ),
    )));
  }
}
