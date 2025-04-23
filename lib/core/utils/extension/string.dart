import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

extension StringExt on String {
  String get addSuffixColon => '$this:';
  String get addPreffixHttpsUrl {
    if (startsWith('http://') || startsWith('https://')) {
      return this;
    }
    return 'https://$this';
  }

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

  Future<void> goToUrl() async {
    try {
      final Uri encodedURl = Uri.parse(this);
      if (await canLaunchUrl(encodedURl)) {
        await launchUrl(encodedURl);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
