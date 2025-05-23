import 'package:ufersa_hub/features/shared/firebase/domain/firebase_model.dart';

class DocumentModel extends FirebaseModel {
  final String name;
  final String? description;
  final String? fileUrl;
  final String? base64;
  final String? link;
  final String docExtension;
  DocumentModel({
    required this.name,
    this.fileUrl,
    this.base64,
    super.uid = '',
    this.description,
    this.link,
    this.docExtension = 'pdf',
  });

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (uid.isNotEmpty) 'uid': uid,
      'name': name,
      if (description != null && description!.isNotEmpty)
        'description': description,
      if (fileUrl != null && fileUrl!.isNotEmpty) 'fileUrl': fileUrl,
      if (base64 != null && base64!.isNotEmpty) 'file': base64,
      if (link != null && link!.isNotEmpty) 'link': link,
      'docExtension': docExtension,
    };
  }

  factory DocumentModel.fromMap(Map<String, dynamic> map) {
    return DocumentModel(
      uid: map['uid'] as String,
      name: map['name'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
      fileUrl: map['fileUrl'] != null ? map['fileUrl'] as String : null,
      base64: map['file'] != null ? map['file'] as String : null,
      link: map['link'] != null ? map['link'] as String : null,
      docExtension:
          map['docExtension'] != null ? map['docExtension'] as String : 'pdf',
    );
  }

  DocumentModel copyWith({
    String? uid,
    String? name,
    String? description,
    String? fileUrl,
    String? base64,
    String? link,
    String? docExtension,
  }) {
    return DocumentModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      description: description ?? this.description,
      fileUrl: fileUrl ?? this.fileUrl,
      base64: base64 ?? this.base64,
      link: link ?? this.link,
      docExtension: docExtension ?? this.docExtension,
    );
  }
}
