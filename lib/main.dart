import 'dart:async';

import 'package:design_system/design_system.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logging/logging.dart';
import 'package:ufersa_hub/core/dependecy/dependency.dart';
import 'package:ufersa_hub/features/app.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await DSColors.inicialize(secundaryColor: Color(0xFFFF7200));
      await _initGoogleMobileAds();
      await Firebase.initializeApp();
      setup();
      runApp(const MyApp());
    },
    (error, stackTrace) {
      Logger('main').severe(error, stackTrace);
    },
  );
}

Future<InitializationStatus> _initGoogleMobileAds() {
  return MobileAds.instance.initialize();
}
