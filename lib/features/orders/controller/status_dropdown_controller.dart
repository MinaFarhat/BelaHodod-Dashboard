import 'package:get/get.dart';
class StatusDropdownController extends GetxController {
  Rx<String> selectedItem = "في طريقه إليك".obs;

  void change(String newValue) {
    selectedItem.value = newValue;
  }
}
