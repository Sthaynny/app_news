extension StringExt on String {
  String get addSuffixColon => '$this:';

  (double lat, double log) get getLocalizationString {
    try {
      final parts = split(',');
      final lat = double.parse(parts[0].trim());
      final lng = double.parse(parts[1].trim());
      return (lat, lng);
    } catch (e) {
      return (0.0, 0);
    }
  }
}
