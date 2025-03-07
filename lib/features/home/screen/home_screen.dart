import 'package:app_news/core/strings/strings.dart';
import 'package:app_news/features/home/screen/components/card_news_widget.dart';
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
    viewmodel.news.execute(true);
    // viewmodel.authenticated.execute();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewsAppBar(
        isLongPress: true,
        actions: [
          ListenableBuilder(
            listenable: viewmodel.news,
            builder: (_, __) {
              return DSIconButton(
                isLoading: viewmodel.news.running,
                onPressed: () => viewmodel.news.execute(true),
                icon: DSIcons.refresh_outline,
              );
            },
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: viewmodel.news,
        builder: (_, __) {
          if (viewmodel.news.completed) {
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: DSSpacing.xs.value),
              itemCount: viewmodel.newsList.length,
              itemBuilder: (_, index) {
                final news = viewmodel.newsList[index];
                return CardNewsWidget(news: news);
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
                  onPressed: () => viewmodel.news.execute(true),
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
