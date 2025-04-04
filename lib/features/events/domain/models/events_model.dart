import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ufersa_hub/core/utils/extension/datetime.dart';
import 'package:ufersa_hub/features/shared/models/location_model.dart';

class EventsModel {
  final String uid;
  final String title;
  final String? description;
  final DateTime start;
  final LocationModel? location;
  final DateTime? end;
  final String? image;
  final String? link;
  EventsModel({
    required this.uid,
    required this.title,
    this.description,
    required this.start,
    this.location,
    this.end,
    this.image,
    this.link,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'title': title,
      if (description != null) 'description': description,
      'start': start.millisecondsSinceEpoch,
      if (location != null) 'location': location!.toMap(),
      if (end != null) 'end': end?.millisecondsSinceEpoch,
      if (image != null) 'image': image,
      if (link != null) 'link': link,
    };
  }

  factory EventsModel.fromMap(Map<String, dynamic> map) {
    final Timestamp start = map['start'] as Timestamp;
    final Timestamp? end = map['end'] as Timestamp?;
    return EventsModel(
      uid: map['uid'] as String,
      title: map['title'] as String,
      description: map['description'],
      start: DateTime.fromMillisecondsSinceEpoch(start.millisecondsSinceEpoch),
      location:
          map['location'] != null
              ? LocationModel.fromMap(map['location'])
              : null,
      end:
          map['end'] != null
              ? DateTime.fromMillisecondsSinceEpoch(end!.millisecondsSinceEpoch)
              : null,
      image: map['image'] != null ? map['image'] as String : null,
      link: map['link'] != null ? map['link'] as String : null,
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
}
