import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ufersa_hub/core/purchase/purchase.dart';

class BannerAdsWidget extends StatelessWidget {
  const BannerAdsWidget({super.key, required this.bannerAdNotifier});

  final ValueNotifier<BannerAd?> bannerAdNotifier;

  @override
  Widget build(BuildContext context) {
    try {
      return ValueListenableBuilder(
        valueListenable: bannerAdNotifier,
        builder: (context, bannerAd, child) {
          if (bannerAd != null && !activitedSignature) {
            return SizedBox(
              width: bannerAd.size.width.toDouble(),
              height: bannerAd.size.height.toDouble(),
              child: AdWidget(ad: bannerAd),
            );
          }
          return SizedBox();
        },
      );
    } catch (e) {
      return SizedBox();
    }
  }
}
