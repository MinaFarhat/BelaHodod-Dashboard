// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:belahododdashboard/features/offers/view/pages/offers_screen.dart';
import 'package:flutter/material.dart';
import 'package:belahododdashboard/features/offers/model/params/offer_params.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../core/constants/urls.dart';
import '../../../core/helper/dialog_helper.dart';
import '../../../core/utils/app_shared_pref.dart';
import '../../products/model/models/image_file_model.dart';
import '../model/models/offer_model.dart';
import '../model/params/offer_product_params.dart';

class OffersController extends GetxController
    with StateMixin<List<OfferModel>> {
  Future<void> getOffers(bool withRefresh) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500)).then((g) {
        if (withRefresh) {
          change(null, status: RxStatus.loading());
        }
      });

      const url = '${Urls.baseUrl}${Urls.offer}/index';
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

        List<OfferModel> offers = [];
        offers = (data['data'] as List<dynamic>)
            .map((i) => OfferModel.fromJson(i))
            .toList();
        if (offers.isNotEmpty) {
          change(offers, status: RxStatus.success());
        } else {
          change(offers, status: RxStatus.empty());
        }
      } else {
        change(null, status: RxStatus.error("حدث خطأ في جلب البيانات"));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future<void> addOffer(OfferParams params, List<ImageFileModel> images,
      List<OfferProductParams> offerProducts) async {
    try {
      DialogHelper.showLoadingDialog();
      const url = '${Urls.baseUrl}${Urls.offer}/store';

      AppSharedPref appSharedPref = AppSharedPref();
      String token = appSharedPref.getToken();
      var headers = {
        'Content-Type': 'multipart/form-data',
        "Authorization": "Bearer $token",
        'Accept': 'application/json',
      };

      Map<String, dynamic> body = params.toJson();

      var multipartRequest = http.MultipartRequest('POST', Uri.parse(url))
        ..headers.addAll(headers);

      // Convert body to FormData format
      var request = jsonToFormData(multipartRequest, body);

      // Add images to the request
      for (int i = 0; i < images.length; i++) {
        http.MultipartFile multipartFile = http.MultipartFile.fromBytes(
            'images[]', images[i].image!.cast(),
            filename: images[i].fileName);
        request.files.add(multipartFile);
      }

      // Add offerProducts to request fields with the specified format
      for (int i = 0; i < offerProducts.length; i++) {
        var element = offerProducts[i];
        request.fields['items[$i]'] = jsonEncode({
          'product_id': element.productId.toString(),
          'quantity': element.quantity.toString(),
        });
      }
      print("request.fields: ${request.fields}");

      var response = await request.send();
      if (response.statusCode == 201) {
        Get.back();
        DialogHelper.showSuccessDialog();
        Get.off(() => const OffersScreen());
      } else {
        var response1 = await http.Response.fromStream(response);
        final result = jsonDecode(response1.body) as Map<String, dynamic>;
        debugPrint(result['message']);
        debugPrint(result['error']);
        debugPrint(result.toString());
        Get.back();
        DialogHelper.showErrorDialog(
            title: "خطأ", description: "حدث خطأ ما يرجى إعادة المحاولة");
      }
    } catch (e) {
      print(e);
      Get.back();
      DialogHelper.showErrorDialog(title: "خطأ", description: e.toString());
    }
  }

  Future<void> updateOffer(
      int offerId,
      OfferParams params,
      List<ImageFileModel> images,
      List<OfferProductParams> offerProducts) async {
    try {
      DialogHelper.showLoadingDialog();
      String url = '${Urls.baseUrl}${Urls.offer}/update/$offerId';

      AppSharedPref appSharedPref = AppSharedPref();
      String token = appSharedPref.getToken();
      var headers = {
        'Content-Type': 'multipart/form-data',
        "Authorization": "Bearer $token",
        'Accept': 'application/json',
        // Add any additional headers here
      };

      Map<String, dynamic> body;
      body = params.toJson();

      var multipartRequest = http.MultipartRequest('POST', Uri.parse(url))
        ..headers.addAll(headers);

      var request = jsonToFormData(multipartRequest, body);

      for (int i = 0; i <= images.length - 1; i++) {
        http.MultipartFile multipartFile = http.MultipartFile.fromBytes(
            'images[]', images[i].image!.cast(),
            filename: images[i].fileName);
        request.files.add(multipartFile);
      }

      for (var element in offerProducts) {
        request.fields['items[]'] = jsonEncode({
          'product_id': element.productId,
          'quantity': element.quantity,
        });

        element.toJson().toString();
      }
      print(request.fields);

      var response = await request.send();

      if (response.statusCode == 201) {
        Get.back();
        DialogHelper.showSuccessDialog();
        Get.off(() => const OffersScreen());
      } else {
        var response1 = await http.Response.fromStream(response);
        final result = jsonDecode(response1.body) as Map<String, dynamic>;
        debugPrint(result['message']);
        debugPrint(result['error']);
        debugPrint(result.toString());
        Get.back();
        DialogHelper.showErrorDialog(
            title: "خطأ", description: "حدث خطأ ما يرجى إعادة المحاولة");
      }
    } catch (e) {
      print(e);
      Get.back();
      DialogHelper.showErrorDialog(title: "خطأ", description: e.toString());
    }
  }

  Future<bool> deleteOffer(
    int offerId,
  ) async {
    try {
      DialogHelper.showLoadingDialog();
      String url = '${Urls.baseUrl}${Urls.offer}/delete/$offerId';
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

  Future<void> searchOffer(String keyword) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500)).then((g) {
        // if (withRefresh) {
        //   change(null, status: RxStatus.loading());
        // }
      });

      String url = '${Urls.baseUrl}${Urls.offer}/search/$keyword';

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

        List<OfferModel> offers = [];
        offers =
            (data as List<dynamic>).map((i) => OfferModel.fromJson(i)).toList();
        if (offers.isNotEmpty) {
          change(offers, status: RxStatus.success());
        } else {
          change(offers, status: RxStatus.empty());
        }
      } else {
        change(null, status: RxStatus.error("حدث خطأ في جلب البيانات"));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}

jsonToFormData(http.MultipartRequest request, Map<String, dynamic> data) {
  for (var key in data.keys) {
    request.fields[key] = data[key].toString();
  }

  return request;
}
