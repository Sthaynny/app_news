import 'dart:io';

import 'package:flutter/foundation.dart';

abstract base class AdHelper {
  static String get bannerAd {
    if (kDebugMode) return _bannerTest;
    if (Platform.isAndroid) {
      return 'ca-app-pub-1899836354814268/4387620929';
    } else if (Platform.isIOS) {
      return '';
    } else {
      return '';
    }
  }

  static String get interstitialAd {
    if (kDebugMode) return _interstitialTest;
    if (Platform.isAndroid) {
      return 'ca-app-pub-1899836354814268/1055165983';
    } else if (Platform.isIOS) {
      return '';
    } else {
      return '';
    }
  }

  static String get _bannerTest => 'ca-app-pub-3940256099942544/6300978111';
  static String get _interstitialTest =>
      'ca-app-pub-3940256099942544/1033173712';
  // static String get _rewardedTest => 'ca-app-pub-3940256099942544/5224354917';
  // static String get _nativeTest => 'ca-app-pub-3940256099942544/2247696110';
}
