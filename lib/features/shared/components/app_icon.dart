import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  AppIcon({super.key, this.scale}) {
    _path = "assets/images/ufersa-logo.png";
  }

  AppIcon.hub({super.key, this.scale}) {
    _path = "assets/images/app-icon.png";
  }

  final double? scale;
  late final String _path;

  @override
  Widget build(BuildContext context) {
    return DSAnimatedSize(child: Image.asset(_path, scale: scale ?? 60));
  }
}
