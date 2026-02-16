import 'dart:convert';
import 'package:belahododdashboard/core/utils/app_shared_pref.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../core/constants/urls.dart';
import '../model/models/order_details_model.dart';
class OrderDetailsController extends GetxController
    with StateMixin<OrderDetailsModel> {
  Future<void> getOrderDetails(int orderId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500)).then((g) {
        change(null, status: RxStatus.loading());
      });

      String url = '${Urls.baseUrl}dashboard/${Urls.orders}/$orderId';

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

        OrderDetailsModel order = OrderDetailsModel.fromJson(data);

        change(order, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.error("حدث خطأ في جلب البيانات"));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
