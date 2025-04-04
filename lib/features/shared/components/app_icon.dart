import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({super.key, this.scale});

  final double? scale;

  @override
  Widget build(BuildContext context) {
    return DSAnimatedSize(
      child: Image.asset("assets/images/ufersa-logo.png", scale: scale ?? 60),
    );
  }
}
