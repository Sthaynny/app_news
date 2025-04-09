import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:ufersa_hub/core/strings/strings.dart';

class BodyErrorDefaultWidget extends StatelessWidget {
  const BodyErrorDefaultWidget({
    super.key,
    required this.title,
    this.onPressed,
  });
  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(DSSpacing.md.value),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DSSpacing.xl.y,
            DSHeadlineLargeText(title, maxLines: 4),
            DSSpacing.xl.y,
            DSPrimaryButton(label: tenteNovamenteString, onPressed: onPressed),
          ],
        ),
      ),
    );
  }
}
