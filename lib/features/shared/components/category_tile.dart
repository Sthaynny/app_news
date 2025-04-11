import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class ChipTile extends StatelessWidget {
  const ChipTile({
    super.key,
    required this.label,
    this.select = false,
    this.onTap,
  });

  final String label;
  final VoidCallback? onTap;
  final bool select;

  Color get colorText =>
      select ? DSColors.neutralMediumWave : DSColors.primary.shade600;
  Color get colorBackground => select ? DSColors.primary : DSColors.transparent;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Chip(
        label: DSCaptionSmallText(
          label,
          color: colorText,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: colorBackground,

        side: BorderSide(color: colorText, width: 1),
      ),
    );
  }
}
