import 'package:ufersa_hub/core/firebase/collections.dart';
import 'package:ufersa_hub/core/utils/request/request_mixin.dart';
import 'package:ufersa_hub/core/utils/result.dart';
import 'package:ufersa_hub/features/documents/domain/models/document_model.dart';
import 'package:ufersa_hub/features/documents/domain/repositories/documents_repository.dart';
import 'package:ufersa_hub/features/shared/firebase/data/service/firebase_service.dart';

class DocumentsRepositoryImpl with RequestMixin implements DocumentsRepository {
  final FirebaseService _firebaseService;

  DocumentsRepositoryImpl({required FirebaseService firebaseService})
    : _firebaseService = firebaseService;

  @override
  Future<Result<void>> createDocuments(DocumentModel model) {
    return request(() async {
      return await _firebaseService.create(
        model,
        collection: Collections.documents,
      );
    });
  }

  @override
  Future<Result<void>> deleteDocuments(String uid) {
    return request(() async {
      return await _firebaseService.delete(
        uid,
        collection: Collections.documents,
      );
    });
  }

  @override
  Future<Result<List<DocumentModel>>> getDocuments() {
    return request<List<DocumentModel>>(() {
      return _firebaseService.get(
        orderBy: Documents.start,
        descending: true,
        collection: Collections.documents,
        mapper: (p0) => DocumentModel.fromMap(p0),
      );
    });
  }

  @override
  Future<Result<void>> updateDocuments(DocumentModel model) {
    return request(
      () => _firebaseService.update(model, collection: Collections.documents),
    );
  }
}
