import 'dart:developer';
import 'dart:io';

import 'package:app_news/core/utils/commands.dart';
import 'package:app_news/core/utils/extension/bool.dart';
import 'package:app_news/core/utils/extension/filte.dart';
import 'package:app_news/core/utils/permission/premission_service.dart';
import 'package:app_news/core/utils/result.dart';
import 'package:app_news/features/shared/news/data/repositories/news_repository.dart';
import 'package:app_news/features/shared/news/domain/models/news_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CreateNewsViewmodel {
  final NewsRepository _repository;
  final PermissionService _permissionService;

  late final CommandAction<void, (String title, String description)> createNews;
  late final CommandAction<void, int?> manegesImages;
  late final CommandBase<bool> getPermission;

  List<File> images = [];
  bool? isPermissionGranted;

  CreateNewsViewmodel({
    required NewsRepository repository,
    required PermissionService permissionService,
  }) : _repository = repository,
       _permissionService = permissionService {
    createNews = CommandAction<void, (String title, String description)>((
      data,
    ) {
      final (title, description) = data;
      final imagesList = images.map((e) => e.convertIntoBase64).toList();

      final model = NewsModel(
        title: title,
        description: description,
        uid: '',
        imagesUrl: imagesList,
        publishedAt: DateTime.now(),
      );
      return _repository.createNews(model);
    });

    manegesImages = CommandAction<void, int?>(_manegesImages);
    getPermission = CommandBase<bool>(() async {
      if (await _permissionService.isPermissionGranted(Permission.photos)) {
        isPermissionGranted = true;
        return Result.ok(true);
      } else {
        final result = await _requestPermission();
        isPermissionGranted = result.isTrue;
        return Result.ok(isPermissionGranted);
      }
    });
  }

  Future<Result<void>> _manegesImages(int? index) async {
    if (index != null) images.removeAt(index);
    try {
      final result = await ImagePicker().pickMultiImage();
      images.addAll(result.map((e) => File(e.path)).toList());
    } catch (e) {
      log(e.toString());
    }
    return Result.ok();
  }

  Future<bool?> _requestPermission() async =>
      await _permissionService.requestPermission(Permission.photos);

  Future<void> openAppSettings() async =>
      await _permissionService.openSettings();

  Future<void> getImages() async {}
}
