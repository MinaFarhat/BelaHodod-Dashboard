import 'package:get/get.dart';

class MostUsedButtonController extends GetxController {
  String route;
  MostUsedButtonController ({required this.route});

  void navigateToAddSection() {
    Get.toNamed('/$route');
  }
}