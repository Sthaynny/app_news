import 'dart:convert';
import 'dart:io';

extension FileExt on File {
  String get convertIntoBase64 {
    final File file = this;
    List<int> imageBytes = file.readAsBytesSync();
    String base64File = base64Encode(imageBytes);
    return base64File;
  }
}
