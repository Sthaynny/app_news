import 'package:app_news/core/strings/strings.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class NewsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NewsAppBar({super.key, this.onBackButtonPressed, this.canPop});
  final VoidCallback? onBackButtonPressed;
  final bool? canPop;

  @override
  Widget build(BuildContext context) {
    return DSHeader.customTitle(
      customTitle: Row(
        children: [
          DSSpacing.sm.x,
          DSAnimatedSize(
            child: Image.asset("assets/images/world-news.png", scale: 15),
          ),
          DSSpacing.sm.x,
          DSHeadlineSmallText(StringsApp.appName.label),
        ],
      ),
      canPop: canPop,
      onBackButtonPressed: onBackButtonPressed,
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 56.0);
}
