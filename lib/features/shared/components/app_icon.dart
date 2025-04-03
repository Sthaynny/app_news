import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return DSAnimatedSize(
      child: Image.asset("assets/images/app-icon.png", scale: 15),
    );
  }
}
