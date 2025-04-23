import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:ufersa_hub/core/strings/strings.dart';
import 'package:ufersa_hub/features/shared/components/app_icon.dart';

class NewsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NewsAppBar({
    super.key,
    this.onBackButtonPressed,
    this.canPop,
    this.actions,
    this.leading,
    this.title,
  });
  final VoidCallback? onBackButtonPressed;
  final bool? canPop;
  final List<Widget>? actions;
  final Widget? leading;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return DSHeader.customTitle(
      customTitle: Row(
        children: [
          DSSpacing.sm.x,
          AppIcon(),
          DSSpacing.sm.x,
          DSHeadlineSmallText(title ?? appNameString),
        ],
      ),
      canPop: canPop,
      leading: leading,
      onBackButtonPressed: onBackButtonPressed,
      actions: [
        if (actions != null)
          ...actions!.map(
            (e) => Padding(
              padding: EdgeInsets.only(left: DSSpacing.xxs.value),
              child: e,
            ),
          ),
        DSSpacing.xs.x,
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 56.0);
}
