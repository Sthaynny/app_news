import 'dart:async';
import 'dart:developer';

import 'package:app_news/core/dependecy/dependency.dart';
import 'package:app_news/core/router/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      setup();
      runApp(const MyApp());
    },
    (error, stackTrace) {
      log('runZonedGuarded: Caught error in my root zone.');
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: router, title: 'App News');
  }
}
