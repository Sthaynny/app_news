import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class ButtonAddItemWidget extends StatelessWidget {
  const ButtonAddItemWidget({
    super.key,
    required this.label,
    required this.onPressed,
    this.isVisible = false,
  });

  final String label;
  final VoidCallback onPressed;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Material(
        color: DSColors.transparent,
        borderRadius: BorderRadius.circular(DSSpacing.xs.value),
        elevation: 3,
        child: IgnorePointer(
          ignoring: !isVisible,
          child: DSPrimaryButton(
            onPressed: onPressed,
            label: label,
            trailingIcon: Icon(
              Icons.add,
              color: DSColors.neutralMediumWave,
              size: DSSpacing.lg.value,
            ),
          ),
        ),
      ),
    );
  }
}
