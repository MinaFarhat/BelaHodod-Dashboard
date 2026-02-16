import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../core/constants/urls.dart';
import '../../../core/utils/app_shared_pref.dart';
import '../model/models/role_model.dart';

class PermissionsController extends GetxController
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
        "Authorization": "Bearer $token"
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
}
