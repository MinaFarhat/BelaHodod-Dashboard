import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../core/constants/urls.dart';
import '../../../core/helper/dialog_helper.dart';
import 'dart:typed_data';
import '../../../core/utils/app_shared_pref.dart';

class ReportsController extends GetxController with StateMixin<Uint8List?> {
  Future<void> getReport() async {
    DialogHelper.showLoadingDialog();

    try {
      await Future.delayed(const Duration(milliseconds: 500)).then((g) {});

      const url = '${Urls.baseUrl}${Urls.report}';
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
        Get.back();
        DialogHelper.showSuccessDialog();
        Uint8List pdfData = response.bodyBytes;
        change(pdfData, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.error("حدث خطأ في جلب البيانات"));
      }
    } catch (e) {
      change(null, status: RxStatus.error("حدث خطأ في جلب البيانات"));
    }
  }

  void downloadFile(String url, String filename) {
    // Create an anchor element
// Programmatically click the anchor
  }
}
