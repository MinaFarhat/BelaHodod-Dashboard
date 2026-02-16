import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../core/constants/urls.dart';
import '../../../core/helper/dialog_helper.dart';
import '../../../core/utils/app_shared_pref.dart';
import '../../products/model/models/image_file_model.dart';
import '../model/news_model.dart';
import '../model/news_params.dart';

class NewsController extends GetxController with StateMixin<List<NewsModel>> {
  Future<void> getNews(bool withRefresh) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500)).then((g) {
        if (withRefresh) {
          change(null, status: RxStatus.loading());
        }
      });

      const url = '${Urls.baseUrl}${Urls.news}/index';
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

        List<NewsModel> news = [];
        news = (data['data'] as List<dynamic>)
            .map((i) => NewsModel.fromJson(i))
            .toList();
        if (news.isNotEmpty) {
          change(news, status: RxStatus.success());
        } else {
          change(news, status: RxStatus.empty());
        }
      } else {
        change(null, status: RxStatus.error("حدث خطأ في جلب البيانات"));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future<bool> addNews(NewsParams params, List<ImageFileModel> images) async {
    try {
      DialogHelper.showLoadingDialog();
      const url = '${Urls.baseUrl}${Urls.news}/store';
      AppSharedPref appSharedPref = AppSharedPref();
      String token = appSharedPref.getToken();
      var headers = {
        'Content-Type': 'multipart/form-data',
        'Accept': 'application/json',
        "Authorization": "Bearer $token"

        // Add any additional headers here
      };

      Map<String, dynamic> body = params.toJson();
      var multipartRequest = http.MultipartRequest('POST', Uri.parse(url))
        ..headers.addAll(headers);

      var request = jsonToFormData(multipartRequest, body);

      for (int i = 0; i <= images.length - 1; i++) {
        http.MultipartFile multipartFile = http.MultipartFile.fromBytes(
            'image[]', images[i].image!.cast(),
            filename: images[i].fileName);
        request.files.add(multipartFile);
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        Get.back();
        DialogHelper.showSuccessDialog();
        Get.offNamed("/news_screen");
        return true;
      } else {
        var response1 = await http.Response.fromStream(response);
        final result = jsonDecode(response1.body) as Map<String, dynamic>;
        debugPrint(result['message']);
        debugPrint(result['error']);
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

  Future<bool> updateNews(
      int newsId, NewsParams params, List<ImageFileModel> images) async {
    try {
      DialogHelper.showLoadingDialog();
      String url = '${Urls.baseUrl}${Urls.news}/update/$newsId';
      AppSharedPref appSharedPref = AppSharedPref();
      String token = appSharedPref.getToken();

      var headers = {
        'Content-Type': 'multipart/form-data',
        'Accept': 'application/json',
        "Authorization": "Bearer $token"

        // Add any additional headers here
      };

      Map<String, dynamic> body = params.toJson();
      var multipartRequest = http.MultipartRequest('POST', Uri.parse(url))
        ..headers.addAll(headers);

      var request = jsonToFormData(multipartRequest, body);

      for (int i = 0; i <= images.length - 1; i++) {
        http.MultipartFile multipartFile = http.MultipartFile.fromBytes(
            'image[]', images[i].image!.cast(),
            filename: images[i].fileName);
        request.files.add(multipartFile);
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        Get.back();
        DialogHelper.showSuccessDialog();
        Get.offNamed("/news_screen");
        return true;
      } else {
        var response1 = await http.Response.fromStream(response);
        final result = jsonDecode(response1.body) as Map<String, dynamic>;
        debugPrint(result['message']);
        debugPrint(result['error']);
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

  Future<bool> deleteNews(
    int newsId,
  ) async {
    try {
      DialogHelper.showLoadingDialog();
      String url = '${Urls.baseUrl}${Urls.news}/delete/$newsId';
      AppSharedPref appSharedPref = AppSharedPref();
      String token = appSharedPref.getToken();
      var headers = {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token"

        // Add any additional headers here
      };

      var response = await http.delete(Uri.parse(url), headers: headers);

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

  jsonToFormData(http.MultipartRequest request, Map<String, dynamic> data) {
    for (var key in data.keys) {
      request.fields[key] = data[key].toString();
    }

    return request;
  }
}
