import 'package:ufersa_hub/features/shared/firebase/domain/firebase_model.dart';

class DocumentModel extends FirebaseModel {
  final String name;
  final String? description;
  final String? url;
  final String? base64;
  DocumentModel({
    required this.name,
    this.url,
    this.base64,
    super.uid = '',
    this.description,
  }) {
    assert(
      url != null || base64 != null,
      'Either url or base64 must be provided',
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (uid.isNotEmpty) 'uid': uid,
      'name': name,
      if (description != null && description!.isNotEmpty)
        'description': description,
      if (url != null && url!.isNotEmpty) 'url': url,
      if (base64 != null && base64!.isNotEmpty) 'base64': base64,
    };
  }

  factory DocumentModel.fromMap(Map<String, dynamic> map) {
    return DocumentModel(
      uid: map['uid'] as String,
      name: map['name'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
      url: map['url'] != null ? map['url'] as String : null,
      base64: map['base64'] != null ? map['base64'] as String : null,
    );
  }

  DocumentModel copyWith({
    String? uid,
    String? name,
    String? description,
    String? url,
    String? base64,
  }) {
    return DocumentModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      description: description ?? this.description,
      url: url ?? this.url,
      base64: base64 ?? this.base64,
    );
  }
}
