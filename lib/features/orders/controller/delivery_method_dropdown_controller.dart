import 'package:get/get.dart';
class DeliveryMethodDropdownController extends GetxController {
  Rx<String> selectedItem = "شحن الى محافظة أخرى".obs;

  void change(String newValue) {
    selectedItem.value = newValue;
  }
}
