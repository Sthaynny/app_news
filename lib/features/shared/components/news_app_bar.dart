import 'package:app_news/core/router/app_router.dart';
import 'package:app_news/core/strings/strings.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NewsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NewsAppBar({
    super.key,
    this.onBackButtonPressed,
    this.canPop,
    this.isLongPress = false,
  });
  final VoidCallback? onBackButtonPressed;
  final bool? canPop;
  final bool isLongPress;

  @override
  Widget build(BuildContext context) {
    return DSHeader.customTitle(
      customTitle: GestureDetector(
        onLongPress:
            isLongPress ? () => context.go(AppRouters.home.path) : null,
        child: Row(
          children: [
            DSSpacing.sm.x,
            DSAnimatedSize(
              child: Image.asset("assets/images/world-news.png", scale: 15),
            ),
            DSSpacing.sm.x,
            DSHeadlineSmallText(StringsApp.appName.label),
          ],
        ),
      ),
      canPop: canPop,
      onBackButtonPressed: onBackButtonPressed,
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 56.0);
}
