// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:belahododdashboard/features/permissions/model/params/permission_params.dart';
import 'package:belahododdashboard/features/permissions/model/params/role_params.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../core/constants/urls.dart';
import '../../../core/helper/dialog_helper.dart';
import '../../../core/utils/app_shared_pref.dart';
import '../model/models/role_model.dart';

class RolesController extends GetxController
    with StateMixin<List<PermessionModel>> {
  Future<void> getAllPermissions(bool withRefresh) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500)).then((g) {
        if (withRefresh) {
          change(null, status: RxStatus.loading());
        }
      });

      const url = '${Urls.baseUrl}permission/index';

      AppSharedPref appSharedPref = AppSharedPref();
      String token = appSharedPref.getToken();
      var headers = {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token",
        'Accept': 'application/json',
        // Add any additional headers here
      };
      var response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        List<PermessionModel> permissions = [];
        permissions = (data as List<dynamic>)
            .map((i) => PermessionModel.fromJson(i))
            .toList();
        if (permissions.isNotEmpty) {
          change(permissions, status: RxStatus.success());
        } else {
          change(permissions, status: RxStatus.empty());
        }
      } else {
        change(null, status: RxStatus.error("حدث خطأ في جلب البيانات"));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future<void> addPermissionsToRole(
      List<PermissionParams> params, int roleId) async {
    try {
      // Show a loading dialog
      DialogHelper.showLoadingDialog();

      // Define the URL with the roleId
      String url = '${Urls.baseUrl}permission/$roleId/add_permissions_to_role';

      // Get the token from shared preferences
      AppSharedPref appSharedPref = AppSharedPref();
      String token = appSharedPref.getToken();

      // Define the headers
      var headers = {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token",
        'Accept': 'application/json',
      };

      // Encode the list of PermissionParams into JSON
      var body = jsonEncode(params.map((param) => param.toJson()).toList());

      // Make the POST request
      var response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      print(params.length);
      print("response: $response");
      // Handle the response
      if (response.statusCode == 200) {
        Get.back();
        DialogHelper.showSuccessDialog();
        Get.offNamed("/sys_roles");
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

  Future<void> getRoles(bool withRefresh) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500)).then((g) {
        if (withRefresh) {
          change(null, status: RxStatus.loading());
        }
      });

      const url = '${Urls.baseUrl}${Urls.role}/index';

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
        var data = jsonDecode(response.body);

        List<PermessionModel> roles = [];
        roles = (data as List<dynamic>)
            .map((i) => PermessionModel.fromJson(i))
            .toList();
        if (roles.isNotEmpty) {
          change(roles, status: RxStatus.success());
        } else {
          change(roles, status: RxStatus.empty());
        }
      } else {
        change(null, status: RxStatus.error("حدث خطأ في جلب البيانات"));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future<void> addRole(RoleParams params) async {
    try {
      DialogHelper.showLoadingDialog();
      const url = '${Urls.baseUrl}${Urls.role}/store';
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
      if (response.statusCode == 201) {
        Get.back();
        DialogHelper.showSuccessDialog();
        Get.offNamed("/sys_roles");
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

  Future<void> updateRole(int roleId, RoleParams params) async {
    try {
      DialogHelper.showLoadingDialog();
      String url = '${Urls.baseUrl}${Urls.role}/update/$roleId';

      AppSharedPref appSharedPref = AppSharedPref();
      String token = appSharedPref.getToken();
      var headers = {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token"

        // Add any additional headers here
      };
      print("update role:");

      var body = jsonEncode(params.toJson());

      var response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      print(response.statusCode);

      if (response.statusCode == 201) {
        Get.back();
        DialogHelper.showSuccessDialog();
        Get.offNamed("/sys_roles");
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

  Future<bool> deleteRole(
    int roleId,
  ) async {
    try {
      DialogHelper.showLoadingDialog();
      String url = '${Urls.baseUrl}${Urls.role}/delete/$roleId';
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

      if (response.statusCode == 204) {
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

  Future<void> getRolePermissions(bool withRefresh, int roleId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500)).then((g) {
        if (withRefresh) {
          change(null, status: RxStatus.loading());
        }
      });

      String url = '${Urls.baseUrl}${Urls.permission}/show/$roleId';

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
        var data = jsonDecode(response.body);

        List<PermessionModel> roles = [];
        roles = (data as List<dynamic>)
            .map((i) => PermessionModel.fromJson(i))
            .toList();
        if (roles.isNotEmpty) {
          change(roles, status: RxStatus.success());
        } else {
          change(roles, status: RxStatus.empty());
        }
      } else {
        change(null, status: RxStatus.error("حدث خطأ في جلب البيانات"));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
