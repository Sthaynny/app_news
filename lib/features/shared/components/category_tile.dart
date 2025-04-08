import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:ufersa_hub/features/shared/news/domain/enums/category_post.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    super.key,
    required this.category,
    this.select = false,
    this.onTap,
  });

  final CategoryPost category;
  final VoidCallback? onTap;
  final bool select;

  Color get colorText =>
      select ? DSColors.neutralMediumWave : DSColors.primary.shade600;
  Color get colorBackground => select ? DSColors.primary : DSColors.transparent;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Chip(
          label: DSCaptionSmallText(
            category.labelPtBr,
            color: colorText,
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: colorBackground,

          side: BorderSide(color: colorText, width: 1),
        ),
      ),
    );
  }
}
