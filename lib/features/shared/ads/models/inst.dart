import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ufersa_hub/core/utils/ads/ad_helper.dart';

class InterstitialAdManager {
  InterstitialAd? _interstitialAd;

  void loadAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAd,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('Erro ao carregar intersticial: $error');
        },
      ),
    );
  }

  void showAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          ad.dispose();
          loadAd(); // recarrega para próxima vez
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          debugPrint('Erro ao mostrar: $error');
          ad.dispose();
        },
      );

      _interstitialAd!.show();
      _interstitialAd = null;
    }
  }
}
