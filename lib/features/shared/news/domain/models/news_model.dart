// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ufersa_hub/features/shared/domain/enums/category_post.dart';
import 'package:ufersa_hub/features/shared/domain/enums/course_hub.dart';

class NewsModel {
  final String uid;
  final String title;
  final String? description;
  final List<String> images;
  final CategoryPost categoryNews;
  final CourseHub? course;
  final String? link;
  final DateTime publishedAt;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (uid.isNotEmpty) 'uid': uid,
      'title': title,
      if (description != null && description!.isNotEmpty)
        'description': description,
      'images': images,
      'publishedAt': publishedAt,
      'category': categoryNews.name,
      if (course != null) 'course': course!.name,
      if (link != null && link!.isNotEmpty) 'link': link,
    };
  }

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    final Timestamp timestamp = map['publishedAt'] as Timestamp;
    return NewsModel(
      uid: map['uid'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      images: List<String>.from((map['images'] as List)),
      categoryNews: CategoryPost.values.firstWhere(
        (element) => element.name == map['category'],
        orElse: () => CategoryPost.other,
      ),
      publishedAt: DateTime.fromMillisecondsSinceEpoch(
        timestamp.millisecondsSinceEpoch,
      ),
      course:
          map['course'] != null
              ? CourseHub.values.firstWhere(
                (element) => element.name == map['course'],
              )
              : null,
      link: map['link'],
    );
  }

  NewsModel({
    required this.uid,
    required this.title,
    this.description,
    required this.images,
    this.course,
    required this.publishedAt,
    required this.categoryNews,
    this.link,
  });

  NewsModel copyWith({
    String? uid,
    String? title,
    String? description,
    List<String>? images,
    CategoryPost? categoryNews,
    CourseHub? course,
    String? link,
    DateTime? publishedAt,
  }) {
    return NewsModel(
      uid: uid ?? this.uid,
      title: title ?? this.title,
      description: description ?? this.description,
      images: images ?? this.images,
      categoryNews: categoryNews ?? this.categoryNews,
      course: course ?? this.course,
      link: link ?? this.link,
      publishedAt: publishedAt ?? this.publishedAt,
    );
  }
}
