import 'dart:typed_data';

class FileModel {
  String? fileName;
  Uint8List? fileData; // Change from image to fileData

  FileModel(this.fileName, this.fileData);
}
