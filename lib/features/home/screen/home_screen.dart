import 'package:app_news/core/strings/strings.dart';
import 'package:app_news/core/utils/extension/datetime.dart';
import 'package:app_news/features/home/screen/home_view_model.dart';
import 'package:app_news/features/home/utils/home_strings.dart';
import 'package:app_news/features/shared/components/news_app_bar.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.viewmodel});
  final HomeViewModel viewmodel;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel get viewmodel => widget.viewmodel;

  @override
  void initState() {
    viewmodel.news.execute();
    // viewmodel.authenticated.execute();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewsAppBar(isLongPress: true),
      body: ListenableBuilder(
        listenable: viewmodel.news,
        builder: (_, __) {
          if (viewmodel.news.completed) {
            return ListView.builder(
              itemCount: viewmodel.newsList.length,
              itemBuilder: (_, index) {
                final news = viewmodel.newsList[index];
                return Card(
                  child: ListTile(
                    title: DSHeadlineLargeText(news.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DSSpacing.xs.y,
                        DSBodyText(news.description, maxLines: 5),
                        DSSpacing.xs.y,
                        DSCaptionSmallText(news.publishedAt.toPublishedAt),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          if (viewmodel.news.error && viewmodel.newsList.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DSSpacing.xl.y,
                DSBodyText(HomeStrings.error.label),
                DSSpacing.xl.y,
                DSPrimaryButton(
                  label: StringsApp.tenteNovamente.label,
                  onPressed: viewmodel.news.execute,
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
