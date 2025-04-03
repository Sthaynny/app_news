import 'package:ufersa_hub/core/router/app_router.dart';
import 'package:ufersa_hub/core/utils/extension/build_context.dart';
import 'package:ufersa_hub/core/utils/extension/datetime.dart';
import 'package:ufersa_hub/features/news/args/news_args.dart';
import 'package:ufersa_hub/features/shared/components/image_widget.dart';
import 'package:ufersa_hub/features/shared/news/domain/models/news_model.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class CardNewsWidget extends StatelessWidget {
  const CardNewsWidget({
    super.key,
    required this.news,
    required this.isAuthenticated,
    required this.onAction,
  });
  final NewsModel news;
  final bool isAuthenticated;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () async {
          final result = await context.go(
            AppRouters.detailsNews,
            arguments: NewsArgs(news: news, isAuthenticated: isAuthenticated),
          );
          if (result) {
            onAction();
          }
        },
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (news.images.isNotEmpty) ...[
              ImageWidget(imageBase64: news.images.first),
            ],

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
            Chip(
              label: DSCaptionSmallText(
                news.categoryNews.labelPtBr,
                color: DSColors.primary.shade800,
                fontWeight: FontWeight.bold,
              ),
              backgroundColor: DSColors.transparent,

              side: BorderSide(color: DSColors.primary.shade800, width: 1),
            ),
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
