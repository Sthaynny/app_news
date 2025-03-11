import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

extension FileExt on File {
  String get convertIntoBase64 {
    final File file = this;
    List<int> imageBytes = file.readAsBytesSync();
    String base64File = base64Encode(imageBytes);
    return base64File;
  }

  Future<File> convertBase64ToFile(String base64String, String fileName) async {
    // 1. Decodifica a string Base64 para bytes
    Uint8List bytes = base64Decode(base64String);

    // 2. Obtém o diretório temporário para salvar o arquivo
    Directory tempDir = await getTemporaryDirectory();
    String filePath = '${tempDir.path}/$fileName';

    // 3. Cria o arquivo e grava os bytes nele
    File file = File(filePath);
    await file.writeAsBytes(bytes);

    return file;
  }
}

extension FileExtString on String {
  Future<File> convertBase64ToFile(String fileName) async {
    final base64String = this;
    if (base64String.isEmpty) throw Exception('File is empty');
    // 1. Decodifica a string Base64 para bytes
    Uint8List bytes = base64Decode(base64String);

    // 2. Obtém o diretório temporário para salvar o arquivo
    Directory tempDir = await getTemporaryDirectory();
    String filePath = '${tempDir.path}/$fileName';

    // 3. Cria o arquivo e grava os bytes nele
    File file = File(filePath);
    await file.writeAsBytes(bytes);

    return file;
  }
}
