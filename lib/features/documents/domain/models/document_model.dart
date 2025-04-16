import 'package:ufersa_hub/features/shared/firebase/domain/firebase_model.dart';

class DocumentModel extends FirebaseModel {
  final String name;
  final String? url;
  final String? base64;
  DocumentModel({required this.name, this.url, this.base64, super.uid = ''}) {
    assert(
      url != null || base64 != null,
      'Either url or base64 must be provided',
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'url': url,
      'base64': base64,
    };
  }

  factory DocumentModel.fromMap(Map<String, dynamic> map) {
    return DocumentModel(
      uid: map['uid'] as String,
      name: map['name'] as String,
      url: map['url'] != null ? map['url'] as String : null,
      base64: map['base64'] != null ? map['base64'] as String : null,
    );
  }

  DocumentModel copyWith({
    String? uid,
    String? name,
    String? url,
    String? base64,
  }) {
    return DocumentModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      url: url ?? this.url,
      base64: base64 ?? this.base64,
    );
  }
}
