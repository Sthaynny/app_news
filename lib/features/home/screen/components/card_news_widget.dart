import 'package:app_news/core/router/app_router.dart';
import 'package:app_news/core/utils/extension/build_context.dart';
import 'package:app_news/core/utils/extension/datetime.dart';
import 'package:app_news/features/news/args/news_args.dart';
import 'package:app_news/features/shared/components/image_widget.dart';
import 'package:app_news/features/shared/news/domain/models/news_model.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class CardNewsWidget extends StatelessWidget {
  const CardNewsWidget({
    super.key,
    required this.news,
    required this.isAuthenticated,
  });
  final NewsModel news;
  final bool isAuthenticated;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap:
            () => context.go(
              AppRouters.detailsNews,
              arguments: NewsArgs(news: news, isAuthenticated: isAuthenticated),
            ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageWidget(imageBase64: news.images.first),
            DSSpacing.xs.y,
            DSHeadlineLargeText(news.title),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (news.description?.isNotEmpty ?? false) ...[
              DSSpacing.xs.y,
              DSBodyText(news.description, maxLines: 5),
            ],
            DSSpacing.xs.y,
            DSCaptionSmallText(
              news.publishedAt.toPublishedAt,
              fontWeight: FontWeight.bold,
              color: DSColors.secundary,
            ),
          ],
        ),
      ),
    );
  }
}
