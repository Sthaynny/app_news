import 'package:app_news/features/login/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: AppRouters.home.path,
      builder: (context, state) => Container(),
    ),
    GoRoute(
      path: AppRouters.login.path,
      builder: (context, state) => LoginScreen(),
    ),
  ],
);

enum AppRouters {
  login,
  home;

  const AppRouters();
  String get path => this == home ? '/' : '/$name';
}
