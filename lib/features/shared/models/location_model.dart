class LocationModel {
  final double latitude;
  final double longitude;
  const LocationModel({required this.latitude, required this.longitude});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'latitude': latitude, 'longitude': longitude};
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }
}

extension LocationModelExt on LocationModel {
  String get toLocalizationString => '$latitude,$longitude';

  String get googleMapslocationUrl =>
      "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
}
