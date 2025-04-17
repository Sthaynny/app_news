import 'package:ufersa_hub/core/utils/result.dart';
import 'package:ufersa_hub/features/documents/domain/models/document_model.dart';

abstract class DocumentsRepository {
  Future<Result<List<DocumentModel>>> getDocuments();
  Future<Result<void>> createDocuments(DocumentModel model);
  Future<Result<void>> updateDocuments(DocumentModel model);
  Future<Result<void>> deleteDocuments(String uid);
}
