import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:ufersa_hub/core/utils/commands.dart';
import 'package:ufersa_hub/core/utils/extension/file.dart';
import 'package:ufersa_hub/core/utils/result.dart';
import 'package:ufersa_hub/features/documents/domain/models/document_model.dart';
import 'package:ufersa_hub/features/documents/domain/repositories/documents_repository.dart';

class ManegerDocumentViewmodel {
  final DocumentsRepository _repository;

  late final CommandAction<void, DocumentModel> manegerDoc;
  late final CommandAction<void, Future Function()> updateFile;

  File? _docFile;
  String? _docExtension;
  bool? isPermissionGranted;
  bool _isEdition = false;
  DocumentModel? _documentUpdate;
  DocumentModel? get documentUpdate => _documentUpdate;

  File? get docFile => _docFile;
  String? get docExtension => _docExtension;

  ManegerDocumentViewmodel({required DocumentsRepository repository})
    : _repository = repository {
    manegerDoc = CommandAction<void, DocumentModel>(_manegerDoc);

    updateFile = CommandAction<void, Future Function()>((action) async {
      await action();
      return Result.ok();
    });
  }

  Future<Result<void>> _manegerDoc(DocumentModel model) async {
    if (_isEdition) {
      final data = model.copyWith(
        uid: _documentUpdate?.uid ?? '',
        base64: _docFile?.convertIntoBase64,
        fileUrl: model.fileUrl,
        name: model.name,
        description: model.description ?? '',
        docExtension: _docExtension,
      );
      _documentUpdate = data;
      return _repository.updateDocuments(data);
    } else {
      return _repository.createDocuments(
        model.copyWith(
          base64: _docFile?.convertIntoBase64,
          docExtension: _docExtension,
        ),
      );
    }
  }

  void init(DocumentModel data) async {
    _documentUpdate = data;

    updateFile.execute(() async {
      _docFile =
          data.base64 != null
              ? await data.base64!.convertBase64ToFile(data.name.toLowerCase())
              : null;
      _docExtension = data.docExtension;
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
          allowedExtensions: ['pdf', 'doc', 'docx'],
        );

        _docExtension = result!.files.first.extension;

        _docFile = File(result.files.first.path!);
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
