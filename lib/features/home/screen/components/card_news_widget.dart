import 'package:app_news/core/router/app_router.dart';
import 'package:app_news/core/utils/extension/datetime.dart';
import 'package:app_news/features/shared/components/image_widget.dart';
import 'package:app_news/features/shared/news/domain/models/news_model.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CardNewsWidget extends StatelessWidget {
  const CardNewsWidget({super.key, required this.news});
  final NewsModel news;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => context.go(AppRouters.detailsNews.path, extra: news),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageWidget(imageUrl: news.imagesUrl.first),
            DSSpacing.xs.y,
            DSHeadlineLargeText(news.title),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DSSpacing.xs.y,
            DSBodyText(news.description, maxLines: 5),
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
