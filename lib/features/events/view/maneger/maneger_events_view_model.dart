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

class ManegerEventsViewmodel {
  final EventsRepository _repository;
  final PermissionService _permissionService;

  late final CommandAction<void, EventsModel> manegerEvent;
  late final CommandBase<bool> getPermission;
  late final CommandAction<void, Future Function()> updateImage;
  late final CommandAction<void, DateTime?> startDate;
  late final CommandAction<void, DateTime?> endDate;

  File? _image;
  bool? isPermissionGranted;
  bool _isEdition = false;
  EventsModel? _eventUpdate;
  EventsModel? get eventUpdate => _eventUpdate;
  DateTime? _startDate;
  DateTime? get startDateEventSelected => _startDate;
  DateTime? _endDate;
  DateTime? get endDateSelected => _endDate;

  File? get image => _image;

  ManegerEventsViewmodel({
    required EventsRepository repository,
    required PermissionService permissionService,
  }) : _repository = repository,
       _permissionService = permissionService {
    manegerEvent = CommandAction<void, EventsModel>(_manegerEvent);

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
    updateImage = CommandAction<void, Future Function()>((action) async {
      await action();
      return Result.ok();
    });

    startDate = CommandAction<void, DateTime?>((date) async {
      _startDate = date;
      return Result.ok();
    });
    endDate = CommandAction<void, DateTime?>((date) async {
      _endDate = date;
      return Result.ok();
    });
  }

  Future<Result<void>> _manegerEvent(EventsModel model) async {
    if (_isEdition) {
      final event = model.copyWith(
        uid: _eventUpdate?.uid ?? '',
        start: _startDate,
        end: _endDate,
        image: _image?.convertIntoBase64,
      );
      _eventUpdate = event;
      return _repository.updateEvents(event);
    } else {
      return _repository.createEvents(model);
    }
  }

  Future<bool?> _requestPermission() async =>
      await _permissionService.requestPermission(Permission.photos);

  Future<void> openAppSettings() async =>
      await _permissionService.openSettings();

  void init(EventsModel event) async {
    _eventUpdate = event;
    _startDate = event.start;
    _endDate = event.end;

    updateImage.execute(() async {
      _image =
          event.image != null
              ? await event.image!.convertBase64ToFile(
                'image_${DateTime.now().millisecondsSinceEpoch}',
              )
              : null;

      _isEdition = true;
    });
  }

  void removeImage() {
    updateImage.execute(() async {
      _image = null;
    });
  }

  void addImage() {
    updateImage.execute(() async {
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
