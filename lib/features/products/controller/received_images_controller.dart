// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'dart:convert';

import '../../../core/constants/urls.dart';

class ReceivedImagesController extends GetxController {
  RxList<String> imagePaths = <String>[].obs;

  void parseImages(String imagesJson) {
    try {
      List<dynamic> imagesList = jsonDecode(imagesJson);
      imagePaths.value = imagesList
          .map((image) => "${Urls.imageUrl}${image.toString()}")
          .toList();
    } catch (e) {
      print('Error parsing images: $e');
      imagePaths.value = [];
    }
  }

  bool isValidImageUrl(String url) {
    return url.endsWith('.jpg') ||
        url.endsWith('.jpeg') ||
        url.endsWith('.png') ||
        url.endsWith('.gif');
  }
}
