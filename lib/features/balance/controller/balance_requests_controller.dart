import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../core/constants/urls.dart';
import '../../../core/utils/app_shared_pref.dart';
import '../model/balance_request_model.dart';

class BalanceRequestsController extends GetxController
    with StateMixin<List<BalanceRequestModel>> {
  Future<void> getBalanceRequests(bool withRefresh) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500)).then((g) {
        if (withRefresh) {
          change(null, status: RxStatus.loading());
        }
      });

      const url = '${Urls.baseUrl}${Urls.balanceRequest}';

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

        List<BalanceRequestModel> balanceRequests = [];
        balanceRequests = (data as List<dynamic>)
            .map((i) => BalanceRequestModel.fromJson(i))
            .toList();
        // print("balanceRequests.length: ${balanceRequests.length}");
        if (balanceRequests.isNotEmpty) {
          change(balanceRequests, status: RxStatus.success());
        } else {
          change(balanceRequests, status: RxStatus.empty());
        }
      } else {
        change(null, status: RxStatus.error("حدث خطأ في جلب البيانات"));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
