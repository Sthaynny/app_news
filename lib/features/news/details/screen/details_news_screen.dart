import 'package:app_news/core/router/app_router.dart';
import 'package:app_news/core/strings/strings.dart';
import 'package:app_news/core/utils/extension/build_context.dart';
import 'package:app_news/core/utils/extension/datetime.dart';
import 'package:app_news/features/news/details/screen/details_news_viewmodel.dart';
import 'package:app_news/features/shared/components/image_widget.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class DetailsNewsScreen extends StatefulWidget {
  const DetailsNewsScreen({super.key, required this.viewmodel});
  final DetailsNewsViewmodel viewmodel;

  @override
  State<DetailsNewsScreen> createState() => _DetailsNewsScreenState();
}

class _DetailsNewsScreenState extends State<DetailsNewsScreen> {
  late final DetailsNewsViewmodel viewmodel;
  @override
  void initState() {
    viewmodel = widget.viewmodel;
    viewmodel.deleteNews.addListener(_onResultDelete);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DetailsNewsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewmodel.deleteNews.removeListener(_onResultDelete);
    viewmodel.deleteNews.addListener(_onResultDelete);
  }

  @override
  void dispose() {
    viewmodel.deleteNews.removeListener(_onResultDelete);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final images =
        viewmodel.imagesBase64.map((e) => ImageWidget(imageBase64: e)).toList();
    return Scaffold(
      appBar: DSHeader(
        title: detailsNewsString,
        canPop: true,
        actions:
            viewmodel.isAuthenticated
                ? [
                  DSIconButton(
                    onPressed: () async {
                      final result = await context.go(
                        AppRouters.manegerNews,
                        arguments: viewmodel.news,
                      );
                      if (result != null) {
                        viewmodel.updateScreen.execute(result);
                      }
                    },
                    icon: DSIcons.edit_outline,
                    color: DSColors.primary.shade600,
                  ),
                  DSIconButton(
                    onPressed: () {
                      viewmodel.deleteNews.execute(viewmodel.news.uid);
                    },
                    icon: DSIcons.trash_outline,
                    color: DSColors.error,
                  ),
                ]
                : null,
      ),
      body: ListenableBuilder(
        listenable: widget.viewmodel.updateScreen,
        builder: (context, _) {
          return ListView(
            padding: EdgeInsets.all(DSSpacing.md.value),
            children: [
              if (images.isNotEmpty)
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
              DSHeadlineLargeText(viewmodel.news.title),
              DSBodyText(
                viewmodel.news.description,
                overflow: null,
                textAlign: TextAlign.justify,
              ),
              DSSpacing.xs.y,
              Container(
                alignment: Alignment.centerLeft,
                child: Chip(
                  label: DSCaptionSmallText(
                    viewmodel.news.categoryNews.labelPtBr,
                    color: DSColors.primary.shade800,
                    fontWeight: FontWeight.bold,
                  ),
                  backgroundColor: DSColors.transparent,

                  side: BorderSide(color: DSColors.primary.shade800, width: 1),
                ),
              ),
              DSSpacing.xs.y,
              DSCaptionSmallText(
                viewmodel.news.publishedAt.toPublishedAt,
                fontWeight: FontWeight.bold,
                color: DSColors.secundary,
              ),
            ],
          );
        },
      ),
    );
  }

  void _onResultDelete() {
    if (viewmodel.deleteNews.completed) {
      context.back(true);
    }
    if (viewmodel.deleteNews.error) {
      context.showSnackBarError(errorDeleteString);
    }
  }
}
