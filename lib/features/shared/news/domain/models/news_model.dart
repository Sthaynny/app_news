// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class NewsModel {
  final String uid;
  final String title;
  final String? description;
  final List<String> images;
  final DateTime publishedAt;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (uid.isNotEmpty) 'uid': uid,
      'title': title,
      if (description != null) 'description': description,
      'images': images,
      'publishedAt': publishedAt,
    };
  }

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    final Timestamp timestamp = map['publishedAt'] as Timestamp;
    return NewsModel(
      uid: map['uid'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      images: List<String>.from((map['images'] as List)),
      publishedAt: DateTime.fromMillisecondsSinceEpoch(
        timestamp.millisecondsSinceEpoch,
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsModel.fromJson(String source) =>
      NewsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  NewsModel({
    required this.uid,
    required this.title,
    required this.description,
    required this.images,
    required this.publishedAt,
  });

  NewsModel copyWith({
    String? uid,
    String? title,
    String? description,
    List<String>? images,
    DateTime? publishedAt,
  }) {
    return NewsModel(
      uid: uid ?? this.uid,
      title: title ?? this.title,
      description: description ?? this.description,
      images: images ?? this.images,
      publishedAt: publishedAt ?? this.publishedAt,
    );
  }
}
