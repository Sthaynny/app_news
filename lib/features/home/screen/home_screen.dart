import 'package:app_news/core/router/app_router.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DSColors.warning,
      body: Center(
        child: GestureDetector(
          onTap: () => context.go(AppRouters.login.path),
          child: DSHeadlineExtraLargeText('Login'),
        ),
      ),
    );
  }
}
