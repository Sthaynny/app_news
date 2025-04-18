import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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

  Future<File?> saveFile() async {
    try {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      var file = File('');
      final bytes = base64Decode(this);

      // Platform.isIOS comes from dart:io
      if (Platform.isIOS) {
        final dir = await getApplicationDocumentsDirectory();
        file = File('${dir.path}/$fileName');
      }
      if (Platform.isAndroid) {
        var status = await Permission.storage.status;
        if (status != PermissionStatus.granted) {
          status = await Permission.storage.request();
        }
        if (status.isGranted) {
          const downloadsFolderPath = '/storage/emulated/0/Download/';
          Directory dir = Directory(downloadsFolderPath);
          file = File('${dir.path}/$fileName');
        } else {
          return null;
        }
      }
      await file.writeAsBytes(bytes);
      return file;
    } catch (e) {
      return null;
    }
  }
}
