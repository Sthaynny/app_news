import 'package:app_news/core/router/app_router.dart';
import 'package:app_news/core/strings/strings.dart';
import 'package:app_news/core/utils/extension/build_context.dart';
import 'package:app_news/core/utils/extension/datetime.dart';
import 'package:app_news/features/news/args/news_args.dart';
import 'package:app_news/features/shared/components/image_widget.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class DetailsNewsScreen extends StatelessWidget {
  const DetailsNewsScreen({super.key, required this.args});
  final NewsArgs args;

  @override
  Widget build(BuildContext context) {
    final news = args.news;
    final images =
        news.imagesUrl.map((e) => ImageWidget(imageBase64: e)).toList();
    return Scaffold(
      appBar: DSHeader(
        title: detailsNewsString,
        canPop: true,
        actions:
            args.isAuthenticated
                ? [
                  DSIconButton(onPressed: () {}, icon: DSIcons.edit_outline),
                  DSIconButton(
                    onPressed: () {},
                    icon: DSIcons.trash_outline,
                    color: DSColors.error,
                  ),
                ]
                : null,
      ),
      body: ListView(
        padding: EdgeInsets.all(DSSpacing.md.value),
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 250,
              maxWidth: MediaQuery.of(context).size.width - 16,
            ),
            child: CarouselView(
              itemExtent: 350,
              itemSnapping: true,
              elevation: 1,
              children: images,
              onTap:
                  (index) => context.go(
                    AppRouters.detailsNewsImage,
                    arguments: images[index],
                  ),
            ),
          ),
          DSSpacing.xs.y,
          DSHeadlineLargeText(news.title),
          DSSpacing.xs.y,
          DSBodyText(
            news.description,
            overflow: null,
            textAlign: TextAlign.justify,
          ),
          DSSpacing.xs.y,
          DSCaptionSmallText(
            news.publishedAt.toPublishedAt,
            fontWeight: FontWeight.bold,
            color: DSColors.secundary,
          ),
        ],
      ),
    );
  }
}
