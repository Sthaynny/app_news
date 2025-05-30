import 'dart:convert';

import 'package:ufersa_hub/core/utils/extension/datetime.dart';
import 'package:ufersa_hub/features/shared/domain/enums/category_post.dart';

class EventsModel {
  final String uid;
  final String title;
  final String? description;
  final DateTime start;
  final String? location;
  final DateTime? end;
  final String? image;
  final String? link;

  final CategoryPost category;

  EventsModel({
    required this.uid,
    required this.title,
    this.description,
    required this.start,
    this.location,
    this.end,
    this.image,
    required this.category,
    this.link,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (uid.isNotEmpty) 'uid': uid,
      'title': title,
      if (description != null && description!.isNotEmpty)
        'description': description,
      'start': start.millisecondsSinceEpoch,
      if (location != null && location!.isNotEmpty) 'location': location!,
      if (end != null) 'end': end?.millisecondsSinceEpoch,
      if (image != null) 'image': image,
      if (link != null && link!.isNotEmpty) 'link': link,
      'category': category.name,
    };
  }

  factory EventsModel.fromMap(Map<String, dynamic> map) {
    return EventsModel(
      uid: map['uid'] as String,
      title: map['title'] as String,
      description: map['description'],
      start: DateTime.fromMillisecondsSinceEpoch(map['start']),
      location: map['location'],
      end:
          map['end'] != null
              ? DateTime.fromMillisecondsSinceEpoch(map['end'])
              : null,
      image: map['image'] != null ? map['image'] as String : null,
      link: map['link'] != null ? map['link'] as String : null,
      category: CategoryPost.values.firstWhere(
        (element) => element.name == map['category'],
        orElse: () => CategoryPost.other,
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory EventsModel.fromJson(String source) =>
      EventsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  String get toDateEvent {
    if (end != null) {
      return 'De ${start.toDateAt} a ${end!.toDateAt}';
    }

    return start.toDateAt;
  }

  EventsModel copyWith({
    String? uid,
    String? title,
    String? description,
    DateTime? start,
    String? location,
    DateTime? end,
    String? image,
    String? link,
    CategoryPost? category,
  }) {
    return EventsModel(
      uid: uid ?? this.uid,
      title: title ?? this.title,
      description: description ?? this.description,
      start: start ?? this.start,
      location: location ?? this.location,
      end: end ?? this.end,
      image: image ?? this.image,
      link: link ?? this.link,
      category: category ?? this.category,
    );
  }
}
