import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:ufersa_hub/core/router/app_router.dart';
import 'package:ufersa_hub/core/strings/strings.dart';
import 'package:ufersa_hub/core/utils/extension/build_context.dart';
import 'package:ufersa_hub/core/utils/extension/datetime.dart';
import 'package:ufersa_hub/core/utils/extension/string.dart';
import 'package:ufersa_hub/features/news/details/screen/details_news_viewmodel.dart';
import 'package:ufersa_hub/features/shared/components/category_tile.dart';
import 'package:ufersa_hub/features/shared/components/image_widget.dart';

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
    viewmodel.authenticate.execute();
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
        actions: [
          ListenableBuilder(
            listenable: viewmodel.authenticate,
            builder:
                (context, child) =>
                    viewmodel.isAuthenticated
                        ? DSIconButton(
                          key: Key('edit_button'),
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
                        )
                        : SizedBox(),
          ),

          ListenableBuilder(
            listenable: viewmodel.authenticate,
            builder:
                (context, child) =>
                    viewmodel.isAuthenticated
                        ? DSIconButton(
                          key: Key('delete_button'),
                          onPressed: () {
                            viewmodel.deleteNews.execute(viewmodel.news.uid);
                          },
                          icon: DSIcons.trash_outline,
                          color: DSColors.error,
                        )
                        : SizedBox(),
          ),
        ],
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
              DSSpacing.xs.y,
              DSCaptionSmallText(
                viewmodel.news.publishedAt.toPublishedAt,
                fontWeight: FontWeight.bold,
                color: DSColors.secundary,
              ),

              DSSpacing.lg.y,
              DSBodyText(
                viewmodel.news.description,
                overflow: null,
                textAlign: TextAlign.justify,
              ),
              if (viewmodel.news.course != null) ...[
                DSSpacing.lg.y,
                DSCaptionText.rich(
                  TextSpan(
                    text: '${courseString.addSuffixColon} ',
                    children: <TextSpan>[
                      TextSpan(
                        text: viewmodel.news.course?.labelCourseHub,
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),

                  fontWeight: FontWeight.bold,
                  maxLines: 3,
                ),
              ],
              DSSpacing.md.y,
              DSCaptionText(
                categoryString.addSuffixColon,
                fontWeight: FontWeight.bold,
              ),
              DSSpacing.xxs.y,
              Align(
                alignment: Alignment.centerLeft,
                child: CategoryTile(category: viewmodel.news.categoryNews),
              ),
              DSSpacing.xl.y,
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
