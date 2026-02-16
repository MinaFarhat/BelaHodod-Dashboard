// ignore_for_file: avoid_print

import 'package:get/get.dart';
class SelectedItemDropdownController extends GetxController {
  Rx<String> selectedItem = " ".obs;

  void change(String newValue) {
    selectedItem.value = newValue;
    print(selectedItem.value);
  }
}
