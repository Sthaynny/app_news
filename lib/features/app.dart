import 'package:flutter/material.dart';
import 'package:ufersa_hub/core/router/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: '/', routes: routes);
  }
}
