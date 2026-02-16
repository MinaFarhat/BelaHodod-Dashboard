// ignore_for_file: avoid_print

import 'package:get/get.dart';
class UserInfoController extends GetxController {
 static Rx<String?> uName = "".obs;


  void setUserName(String? userName) {
    print("userName: $userName");
    uName.value = userName;
    print("uName.value: ${uName.value}");
  }

}
