import 'dart:convert';

class NewsModel {
  final String uid;
  final String title;
  final String description;
  final List<String> imagesUrl;
  final String publishedAt;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'title': title,
      'description': description,
      'imagesUrl': imagesUrl,
      'publishedAt': publishedAt,
    };
  }

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      uid: map['uid'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      imagesUrl: List<String>.from((map['imagesUrl'] as List)),
      publishedAt: map['publishedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsModel.fromJson(String source) =>
      NewsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  NewsModel({
    required this.uid,
    required this.title,
    required this.description,
    required this.imagesUrl,
    required this.publishedAt,
  });
}
