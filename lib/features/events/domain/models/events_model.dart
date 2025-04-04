import 'dart:convert';

class EventsModel {
  final String uid;
  final String title;
  final String description;
  final DateTime start;
  final String? location;
  final DateTime? end;
  final String? image;
  final String? link;
  EventsModel({
    required this.uid,
    required this.title,
    required this.description,
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
      'description': description,
      'start': start.millisecondsSinceEpoch,
      'location': location,
      'end': end?.millisecondsSinceEpoch,
      'image': image,
      'link': link,
    };
  }

  factory EventsModel.fromMap(Map<String, dynamic> map) {
    return EventsModel(
      uid: map['uid'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      start: DateTime.fromMillisecondsSinceEpoch(map['start'] as int),
      location: map['location'] != null ? map['location'] as String : null,
      end:
          map['end'] != null
              ? DateTime.fromMillisecondsSinceEpoch(map['end'] as int)
              : null,
      image: map['image'] != null ? map['image'] as String : null,
      link: map['link'] != null ? map['link'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EventsModel.fromJson(String source) =>
      EventsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
