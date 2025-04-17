import 'package:ufersa_hub/core/utils/result.dart';
import 'package:ufersa_hub/features/documents/domain/models/document_model.dart';
import 'package:ufersa_hub/features/events/domain/models/events_model.dart';

abstract class DocumentssRepository {
  Future<Result<List<EventsModel>>> getDocuments();
  Future<Result<void>> createDocuments(DocumentModel model);
  Future<Result<void>> updateDocuments(DocumentModel model);
  Future<Result<void>> deleteDocuments(String uid);
}
