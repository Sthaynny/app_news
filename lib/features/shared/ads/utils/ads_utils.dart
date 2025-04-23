import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ufersa_hub/core/utils/ads/ad_helper.dart';

void loadBannerAd({required ValueSetter<Ad?> onAdLoaded}) {
  BannerAd(
    adUnitId: AdHelper.bannerAd,
    request: AdRequest(),
    size: AdSize.banner,
    listener: BannerAdListener(
      onAdLoaded: onAdLoaded,
      onAdFailedToLoad: (ad, err) {
        debugPrint('Failed to load a banner ad: ${err.message}');
        ad.dispose();
      },
    ),
  ).load();
}

 