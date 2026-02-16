import 'dart:convert';
import 'package:belahododdashboard/features/authentication/controller/user_info_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../core/constants/urls.dart';
import '../../../core/helper/dialog_helper.dart';
import '../../../core/utils/app_shared_pref.dart';
import '../model/models/user_model.dart';
import '../model/params/login_params.dart';
import '../model/params/user_info_params.dart';

class AuthenticationController extends GetxController with StateMixin<bool> {
  late AppSharedPref appSharedPref;

  @override
  void onInit() {
    appSharedPref = AppSharedPref();
    super.onInit();
  }

  Future<void> loginApi(LoginParams params) async {
    change(false, status: RxStatus.loading());
    DialogHelper.showLoadingDialog();
    const url = '${Urls.baseUrl}${Urls.login}';

    var headers = {
      'Content-Type': 'application/json',
      // Add any additional headers here
    };

    var body = jsonEncode(params.toJson());
    try {
      var response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        UserModel user = UserModel.fromJson(jsonDecode(response.body));
        UserInfoController userInfoController = Get.find<UserInfoController>();
        userInfoController.setUserName(user.userName);
        appSharedPref.saveToken(user);
        appSharedPref.saveUserId(user);

        Get.back();
        Get.offAllNamed("/home_screen");
        change(true, status: RxStatus.success());
      } else {
        Get.back();
        DialogHelper.showErrorDialog(
            title: "خطأ",
            description: "اسم المستخدم أو كلمة المررور غير صحيحة");
      }
    } catch (e) {
      Get.back();
      DialogHelper.showErrorDialog(title: "خطأ", description: e.toString());
    }
  }

  Future<void> changeUserInfo(UserInfoParams params) async {
    AppSharedPref appSharedPref = AppSharedPref();
    String token = appSharedPref.getToken();
    String userId = appSharedPref.getUserId();
    try {
      DialogHelper.showLoadingDialog();
      var url = '${Urls.baseUrl}${Urls.dashboard}/update-account-info/$userId';

      var headers = {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token",
        'Accept': 'application/json',
        // Add any additional headers here
      };

      var body = jsonEncode(params.toJson());

      var response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        DialogHelper.showSuccessDialog();
        AppSharedPref appSharedPref = AppSharedPref();
        appSharedPref.deleteAll();
        Get.offAllNamed("/login");
      } else {
        Get.back();
        DialogHelper.showErrorDialog(
            title: "خطأ", description: "حدث خطأ ما يرجى إعادة المحاولة");
      }
    } catch (e) {
      Get.back();
      DialogHelper.showErrorDialog(title: "خطأ", description: e.toString());
    }
  }
}
