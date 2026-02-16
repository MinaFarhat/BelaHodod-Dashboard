import 'dart:convert';
import 'package:belahododdashboard/core/utils/app_shared_pref.dart';
import 'package:belahododdashboard/features/orders/model/models/normal_order_model.dart';
import 'package:belahododdashboard/features/orders/model/params/change_status_params.dart';
import 'package:belahododdashboard/features/orders/model/params/processing_order_params.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../core/constants/urls.dart';
import '../../../core/helper/dialog_helper.dart';

class NormalOrdersController extends GetxController
    with StateMixin<List<NormalOrderModel>> {
  Future<void> getDeliveryOrders() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500)).then((g) {
        change(null, status: RxStatus.loading());
      });

      const url = '${Urls.baseUrl}dashboard/${Urls.orders}/delivery';

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

        List<NormalOrderModel> orders = [];
        orders = (data as List<dynamic>)
            .map((i) => NormalOrderModel.fromJson(i))
            .toList();
        if (orders.isNotEmpty) {
          change(orders, status: RxStatus.success());
        } else {
          change(orders, status: RxStatus.empty());
        }
      } else {
        change(null, status: RxStatus.error("حدث خطأ في جلب البيانات"));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future<void> getCancelledOrders() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500)).then((g) {
        change(null, status: RxStatus.loading());
      });

      const url = '${Urls.baseUrl}dashboard/${Urls.orders}/cancelled';

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

        List<NormalOrderModel> orders = [];
        orders = (data as List<dynamic>)
            .map((i) => NormalOrderModel.fromJson(i))
            .toList();
        if (orders.isNotEmpty) {
          change(orders, status: RxStatus.success());
        } else {
          change(orders, status: RxStatus.empty());
        }
      } else {
        change(null, status: RxStatus.error("حدث خطأ في جلب البيانات"));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future<void> getDoneOrders() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500)).then((g) {
        change(null, status: RxStatus.loading());
      });

      const url = '${Urls.baseUrl}dashboard/${Urls.orders}/done';

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

        List<NormalOrderModel> orders = [];
        orders = (data as List<dynamic>)
            .map((i) => NormalOrderModel.fromJson(i))
            .toList();
        if (orders.isNotEmpty) {
          change(orders, status: RxStatus.success());
        } else {
          change(orders, status: RxStatus.empty());
        }
      } else {
        change(null, status: RxStatus.error("حدث خطأ في جلب البيانات"));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future<bool> changeOrderStatus(int orderId, ChangeStatusParams params) async {
    try {
      DialogHelper.showLoadingDialog();

      String url =
          '${Urls.baseUrl}dashboard/${Urls.orders}/update_status/$orderId';

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

  Future<void> getOrderedNowOrders() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500)).then((g) {
        change(null, status: RxStatus.loading());
      });

      const url = '${Urls.baseUrl}dashboard/${Urls.orders}/processing';

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

        List<NormalOrderModel> orders = [];
        orders = (data as List<dynamic>)
            .map((i) => NormalOrderModel.fromJson(i))
            .toList();
        if (orders.isNotEmpty) {
          change(orders, status: RxStatus.success());
        } else {
          change(orders, status: RxStatus.empty());
        }
      } else {
        change(null, status: RxStatus.error("حدث خطأ في جلب البيانات"));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future<void> getPaidByTransferOrders() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500)).then((g) {
        change(null, status: RxStatus.loading());
      });

      const url = '${Urls.baseUrl}dashboard/${Urls.orders}/processing_transfer';

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

        List<NormalOrderModel> orders = [];
        orders = (data as List<dynamic>)
            .map((i) => NormalOrderModel.fromJson(i))
            .toList();
        if (orders.isNotEmpty) {
          change(orders, status: RxStatus.success());
        } else {
          change(orders, status: RxStatus.empty());
        }
      } else {
        change(null, status: RxStatus.error("حدث خطأ في جلب البيانات"));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future<bool> updateOrder(
    int orderId,
    ProcessingOrderParams params,
  ) async {
    try {
      DialogHelper.showLoadingDialog();
      String url = '${Urls.baseUrl}dashboard/${Urls.orders}/get/$orderId';

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
      return true;
    }
  }
}
