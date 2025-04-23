// ignore_for_file: public_member_api_docs, sort_constructors_first

class FirebaseModel {
  final String uid;

  FirebaseModel({required this.uid});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'uid': uid};
  }
}
