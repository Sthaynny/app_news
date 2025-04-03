import 'package:app_news/core/router/app_router.dart';
import 'package:app_news/core/strings/strings.dart';
import 'package:app_news/core/utils/extension/build_context.dart';
import 'package:app_news/features/shared/components/app_icon.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class NewsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NewsAppBar({
    super.key,
    this.onBackButtonPressed,
    this.canPop,
    this.isLongPress = false,
    this.actions,
    this.leading,
    this.title,
  });
  final VoidCallback? onBackButtonPressed;
  final bool? canPop;
  final bool isLongPress;
  final List<Widget>? actions;
  final Widget? leading;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return DSHeader.customTitle(
      customTitle: GestureDetector(
        onLongPress: isLongPress ? () => context.go(AppRouters.login) : null,
        child: Row(
          children: [
            DSSpacing.sm.x,
            AppIcon(),
            DSSpacing.sm.x,
            DSHeadlineSmallText(title ?? appNameString),
          ],
        ),
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
