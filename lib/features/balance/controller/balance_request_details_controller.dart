import 'dart:convert';
import 'package:belahododdashboard/features/balance/model/balance_request_params.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../core/constants/urls.dart';
import '../../../core/helper/dialog_helper.dart';
import '../../../core/utils/app_shared_pref.dart';
import '../model/balance_request_model.dart';

class BalanceRequestsDetailsController extends GetxController
    with StateMixin<BalanceRequestModel> {
  Future<void> getBalanceRequestDetails(int balanceRequestId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500)).then((g) {
        change(null, status: RxStatus.loading());
      });

      String url = '${Urls.baseUrl}${Urls.balanceRequest}/$balanceRequestId';

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

        BalanceRequestModel balanceRequest = BalanceRequestModel.fromJson(data);

        change(balanceRequest, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.error("حدث خطأ في جلب البيانات"));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future<void> updateAmount(
    int balanceId,
    BalanceRequestParams params,
  ) async {
    try {
      DialogHelper.showLoadingDialog();
      String url = '${Urls.baseUrl}${Urls.updateBalance}/$balanceId';
      AppSharedPref appSharedPref = AppSharedPref();
      String token = appSharedPref.getToken();

      var headers = {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token"

        // Add any additional headers here
      };

      var body = jsonEncode(params.toJson());

      var response =
          await http.put(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        Get.back();
        DialogHelper.showSuccessDialog();
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
