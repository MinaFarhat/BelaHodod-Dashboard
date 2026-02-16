// ignore_for_file: avoid_print

import 'package:get/get.dart';
class DropdownController extends GetxController {
  Rx<int> selectedItem = 1.obs;
  Rx<String> selectedStringItems = "".obs;
  Rx<int?> selectedSubSectionId = 1.obs;
  Rx<int?> selectedRoleId = 1.obs;

  void change(int newValue) {
    selectedItem.value = newValue;
  }

  void sChange(String newStringValue) {
    selectedStringItems.value = newStringValue;
  }

  void setSubSectionId(int? id) {
    print(id);
    selectedSubSectionId.value = id;
  }
  void setRoleId(int? id) {
    print(id);
    selectedRoleId.value = id;
  }
}
