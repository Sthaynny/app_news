import 'dart:io';

abstract base class AdHelper {
  static String get bottomAd {
    if (Platform.isAndroid) {
      return 'ca-app-pub-';
    } else if (Platform.isIOS) {
      throw UnsupportedError('Unsupported platform');
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
