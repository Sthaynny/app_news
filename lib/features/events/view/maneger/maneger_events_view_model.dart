import 'dart:developer';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ufersa_hub/core/utils/commands.dart';
import 'package:ufersa_hub/core/utils/extension/bool.dart';
import 'package:ufersa_hub/core/utils/extension/file.dart';
import 'package:ufersa_hub/core/utils/permission/premission_service.dart';
import 'package:ufersa_hub/core/utils/result.dart';
import 'package:ufersa_hub/features/events/data/repositories/events_repository.dart';
import 'package:ufersa_hub/features/events/domain/models/events_model.dart';
import 'package:ufersa_hub/features/shared/news/domain/enums/category_post.dart';

class ManegerEventsViewmodel {
  final EventsRepository _repository;
  final PermissionService _permissionService;

  late final CommandAction<
    void,
    (String title, String description, CategoryPost category)
  >
  createNews;
  late final CommandBase<bool> getPermission;
  late final CommandAction<void, Future Function()> updateListImages;

  File? _image;
  bool? isPermissionGranted;
  bool _isEdition = false;
  EventsModel? _eventUpdate;

  File? get image => _image;

  ManegerEventsViewmodel({
    required EventsRepository repository,
    required PermissionService permissionService,
  }) : _repository = repository,
       _permissionService = permissionService {
    createNews = CommandAction<
      void,
      (String title, String description, CategoryPost category)
    >(_manegerNews);

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
    updateListImages = CommandAction<void, Future Function()>((action) async {
      await action();
      return Result.ok();
    });
  }

  Future<Result<void>> _manegerNews(
    (String title, String description, CategoryPost category) data,
  ) async {
    final (title, description, category) = data;

    final model = EventsModel(
      title: title,
      description: description,
      uid: '',
      image: _image?.convertIntoBase64,

      start: DateTime.now(),
      category: category,
    );
    if (_isEdition) {
      return _repository.updateEvents(
        _eventUpdate?.copyWith(
              title: title,
              description: description,
              image: _image?.convertIntoBase64,
              category: category,
            ) ??
            model,
      );
    } else {
      return _repository.createEvents(model);
    }
  }

  Future<bool?> _requestPermission() async =>
      await _permissionService.requestPermission(Permission.photos);

  Future<void> openAppSettings() async =>
      await _permissionService.openSettings();

  void init(EventsModel news) async {
    _eventUpdate = news;
    updateListImages.execute(() async {
      _image =
          news.image != null
              ? await news.image!.convertBase64ToFile(
                'image_${DateTime.now().millisecondsSinceEpoch}',
              )
              : null;
      _isEdition = true;
    });
  }

  void removeImage() {
    updateListImages.execute(() async {
      _image = null;
    });
  }

  void addImage() {
    updateListImages.execute(() async {
      try {
        final result = await ImagePicker().pickImage(
          source: ImageSource.gallery,
        );
        _image = File(result!.path);
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
