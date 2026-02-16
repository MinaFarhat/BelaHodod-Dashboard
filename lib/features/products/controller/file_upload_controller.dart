// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'dart:typed_data';
import '../../../core/constants/urls.dart';
import '../../../core/helper/dialog_helper.dart';
import '../model/models/file_model.dart';
import '../model/models/image_file_model.dart';
import 'package:http/http.dart' as http;


class FileUploadController extends GetxController {
  Rx<FileModel?> uploadedFile = Rx<FileModel?>(null);

  RxList images = [].obs;

  void addExcelFile(Uint8List file, String fileName) {
    FileModel model = FileModel(fileName, file);
    uploadedFile.value = model;
    uploadFile();
  }

  void addFile(Uint8List file, String fileName) {
    ImageFileModel model = ImageFileModel(fileName, file);
    images.add(model);
  }

  void clear() {
    images.clear();
    uploadedFile.value = null;
  }

  Future<void> uploadFile() async {
try{    if (uploadedFile.value != null) {

  String url = '${Urls.baseUrl}import';
  var request = http.MultipartRequest('POST', Uri.parse(url));

  request.files.add(http.MultipartFile.fromBytes(
    'file',
    uploadedFile.value!.fileData!,
    filename: uploadedFile.value!.fileName,
  ));

  var response = await request.send();
  if (response.statusCode == 200) {
    print("File uploaded successfully");
  } else {
    print("File upload failed with status: ${response.statusCode}");
  }
}
}catch (e){
  DialogHelper.showErrorDialog(title: "خطأ", description: e.toString());
}
  }

}
