import 'dart:async';
import 'dart:developer';

import 'package:design_system/design_system.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ufersa_hub/core/dependecy/dependency.dart';
import 'package:ufersa_hub/core/router/app_router.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await DSColors.inicialize(secundaryColor: Color(0xFFFF7200));
      // await _initGoogleMobileAds();
      await Firebase.initializeApp();
      setup();
      runApp(const MyApp());
    },
    (error, stackTrace) {
      log('runZonedGuarded: Caught error in my root zone.');
    },
  );
}

// Future<InitializationStatus> _initGoogleMobileAds() {
//   return MobileAds.instance.initialize();
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: '/', routes: routes);
  }
}
