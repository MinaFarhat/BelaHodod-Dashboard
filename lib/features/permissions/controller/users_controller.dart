// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';
import 'dart:developer';
import 'package:belahododdashboard/features/authentication/model/params/new_user_params.dart';
import 'package:belahododdashboard/features/authentication/model/params/users_params.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../core/constants/urls.dart';
import '../../../core/helper/dialog_helper.dart';
import '../../../core/utils/app_shared_pref.dart';
import '../../authentication/model/models/wholesale_user_model.dart';
import '../model/params/role_params.dart';

class UsersController extends GetxController
    with StateMixin<List<WholesaleUserModel>> {
  Future<void> getSystemUsers(bool withRefresh) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500)).then((g) {
        if (withRefresh) {
          change(null, status: RxStatus.loading());
        }
      });
      const url = '${Urls.baseUrl}system';

      AppSharedPref appSharedPref = AppSharedPref();
      String token = appSharedPref.getToken();

      var headers = {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token"

        // Add any additional headers here
      };
      var response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        print("enterd");
        var data = jsonDecode(response.body);

        List<WholesaleUserModel> wholesaleUsers = [];

        wholesaleUsers = (data as List<dynamic>)
            .map((i) => WholesaleUserModel.fromJson(i))
            .toList();
        if (wholesaleUsers.isNotEmpty) {
          change(wholesaleUsers, status: RxStatus.success());
        } else {
          change(wholesaleUsers, status: RxStatus.empty());
        }
      } else {
        change(null, status: RxStatus.error("حدث خطأ في جلب البيانات"));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future<void> getWholesaleUsers(bool withRefresh) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500)).then((g) {
        if (withRefresh) {
          change(null, status: RxStatus.loading());
        }
      });
      const url = '${Urls.baseUrl}wholesale';
      AppSharedPref appSharedPref = AppSharedPref();
      String token = appSharedPref.getToken();

      var headers = {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token"

        // Add any additional headers here
      };
      var response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        print("enterd");
        var data = jsonDecode(response.body);

        List<WholesaleUserModel> wholesaleUsers = [];

        wholesaleUsers = (data as List<dynamic>)
            .map((i) => WholesaleUserModel.fromJson(i))
            .toList();
        if (wholesaleUsers.isNotEmpty) {
          change(wholesaleUsers, status: RxStatus.success());
        } else {
          change(wholesaleUsers, status: RxStatus.empty());
        }
      } else {
        change(null, status: RxStatus.error("حدث خطأ في جلب البيانات"));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future<void> updateUser(int userId, UsersParams params) async {
    try {
      DialogHelper.showLoadingDialog();
      String url = '${Urls.baseUrl}dashboard/update-account-info/$userId';

      AppSharedPref appSharedPref = AppSharedPref();
      String token = appSharedPref.getToken();

      var headers = {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token"
        // Add any additional headers here
      };

      var body = jsonEncode(params.toJson());

      var response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('Im in');
        Get.back();
        DialogHelper.showSuccessDialog();
        Get.offNamed("/users_accounts");
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

  Future<void> updateUserRole(int userId, RoleParams params) async {
    try {
      DialogHelper.showLoadingDialog();
      String url = '${Urls.baseUrl}${Urls.role}/update_user_role/$userId';
      print(url);
      AppSharedPref appSharedPref = AppSharedPref();
      String token = appSharedPref.getToken();

      var headers = {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token"
        // Add any additional headers here
      };

      var body = jsonEncode(params.updateUserRoleToJson());

      var response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        Get.back();
        DialogHelper.showSuccessDialog();
        Get.offNamed("/users_accounts");
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

  Future<void> addUser(NewUserParams params, String role) async {
    try {
      DialogHelper.showLoadingDialog();
      const url = '${Urls.baseUrl}register';
      AppSharedPref appSharedPref = AppSharedPref();
      String token = appSharedPref.getToken();
      var headers = {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token"

        // Add any additional headers here
      };

      var body;
      log(role);
      if (role == "S") {
        body = jsonEncode(params.toJson());
      } else if (role == "W") {
        body = jsonEncode(params.wToJson());
      }
      log(body);
      var response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        print("done");
        Get.back();
        DialogHelper.showSuccessDialog();
        Get.offNamed("/users_accounts");
      } else {
        print("not done");

        Get.back();
        DialogHelper.showErrorDialog(
            title: "خطأ", description: "حدث خطأ ما يرجى إعادة المحاولة");
      }
    } catch (e) {
      Get.back();
      DialogHelper.showErrorDialog(title: "خطأ", description: e.toString());
    }
  }

  Future<bool> deleteUser(
    int userId,
  ) async {
    try {
      DialogHelper.showLoadingDialog();
      String url = '${Urls.baseUrl}dashboard/delete-user/$userId';

      AppSharedPref appSharedPref = AppSharedPref();
      String token = appSharedPref.getToken();

      var headers = {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token"
        // Add any additional headers here
      };

      var response = await http.delete(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        Get.back();
        DialogHelper.showSuccessDialog();
        return true;
      } else {
        Get.back();
        DialogHelper.showErrorDialog(
            title: "خطأ", description: "حدث خطأ ما يرجى إعادة المحاولة");
        return false;
      }
    } catch (e) {
      Get.back();
      DialogHelper.showErrorDialog(title: "خطأ", description: e.toString());
      return false;
    }
  }
}
