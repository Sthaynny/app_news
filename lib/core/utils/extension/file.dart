import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
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

  Future<File?> saveFile({String? name, String extensionFile = 'pdf'}) async {
    try {
      final filename =
          '${name != null ? '${name.toLowerCase()}_' : ''}${DateTime.now().millisecondsSinceEpoch}.$extensionFile';
      var file = File('');
      final bytes = base64Decode(this);

      // Platform.isIOS comes from dart:io
      if (Platform.isIOS) {
        final dir = await getApplicationDocumentsDirectory();
        file = File('${dir.path}/$filename');
      }
      if (Platform.isAndroid) {
        const downloadsFolderPath = '/storage/emulated/0/Download';
        Directory dir = Directory(downloadsFolderPath);
        file = File('${dir.path}/$filename');
      }
      await file.writeAsBytes(bytes);
      return file;
    } catch (e) {
      return null;
    }
  }

  Future<File?> downloadFile({
    String? name,
    String extensionFile = 'pdf',
  }) async {
    try {
      final filename =
          '${name != null ? '${name.toLowerCase()}_' : ''}${DateTime.now().millisecondsSinceEpoch}.$extensionFile';
      String dir = '';

      if (Platform.isIOS) {
        dir = (await getApplicationDocumentsDirectory()).path;
      }
      if (Platform.isAndroid) {
        const downloadsFolderPath = '/storage/emulated/0/Download/';
        dir = Directory(downloadsFolderPath).path;
      }

      if (await File('$dir$filename').exists()) return File('$dir$filename');

      String url = this;

      /// requesting http to get url
      var request = await HttpClient().getUrl(Uri.parse(url));

      /// closing request and getting response
      var response = await request.close();

      /// getting response data in bytes
      var bytes = await consolidateHttpClientResponseBytes(response);

      /// generating a local system file with name as 'filename' and path as '$dir/$filename'
      File file = File('$dir$filename');

      /// writing bytes data of response in the file.
      await file.writeAsBytes(bytes);

      return file;
    } catch (err) {
      debugPrint(err.toString());
      return null;
    }
  }
}
