import 'package:get/get.dart';

class SwitchButtonController extends GetxController {
  RxBool switchValue = false.obs;

  void toggleSwitch(bool value) {
    switchValue.value = value;
  }
}