import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ufersa_hub/core/utils/commands.dart';
import 'package:ufersa_hub/core/utils/extension/bool.dart';
import 'package:ufersa_hub/core/utils/extension/file.dart';
import 'package:ufersa_hub/core/utils/permission/premission_service.dart';
import 'package:ufersa_hub/core/utils/result.dart';
import 'package:ufersa_hub/features/documents/domain/models/document_model.dart';
import 'package:ufersa_hub/features/documents/domain/repositories/documents_repository.dart';

class ManegerDocumentViewmodel {
  final DocumentsRepository _repository;
  final PermissionService _permissionService;

  late final CommandAction<void, DocumentModel> manegerDoc;
  late final CommandBase<bool> getPermission;
  late final CommandAction<void, Future Function()> updateFile;

  File? _docFile;
  bool? isPermissionGranted;
  bool _isEdition = false;
  DocumentModel? _documentUpdate;
  DocumentModel? get documentUpdate => _documentUpdate;

  File? get docFile => _docFile;

  ManegerDocumentViewmodel({
    required DocumentsRepository repository,
    required PermissionService permissionService,
  }) : _repository = repository,
       _permissionService = permissionService {
    manegerDoc = CommandAction<void, DocumentModel>(_manegerDoc);

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
    updateFile = CommandAction<void, Future Function()>((action) async {
      await action();
      return Result.ok();
    });
  }

  Future<Result<void>> _manegerDoc(DocumentModel model) async {
    if (_isEdition) {
      final data = model.copyWith(
        uid: model.uid,
        base64: _docFile?.convertIntoBase64,
        url: model.url,
        name: model.name,
        description: model.description ?? '',
      );
      _documentUpdate = data;
      return _repository.updateDocuments(data);
    } else {
      return _repository.createDocuments(model);
    }
  }

  Future<bool?> _requestPermission() async =>
      await _permissionService.requestPermission(Permission.storage);

  Future<void> openAppSettings() async =>
      await _permissionService.openSettings();

  void init(DocumentModel data) async {
    _documentUpdate = data;

    updateFile.execute(() async {
      _docFile =
          data.base64 != null
              ? await data.base64!.convertBase64ToFile(data.name.toLowerCase())
              : null;
      _isEdition = true;
    });
  }

  void removeFile() {
    updateFile.execute(() async {
      _docFile = null;
    });
  }

  void addFile() {
    updateFile.execute(() async {
      try {
        final result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf'],
        );

        _docFile = File(result!.files.first.path!);
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
