import 'package:app_news/core/router/app_router.dart';
import 'package:app_news/core/strings/strings.dart';
import 'package:app_news/core/utils/extension/build_context.dart';
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
  late final HomeViewModel viewmodel;

  @override
  void initState() {
    viewmodel = widget.viewmodel;
    viewmodel.authenticated.execute().then((_) {
      viewmodel.news.execute(true);
    });
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
                return CardNewsWidget(
                  news: news,
                  isAuthenticated: viewmodel.userAuthenticated,
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
                  label: tenteNovamenteString,
                  onPressed: () => viewmodel.news.execute(true),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton:
          viewmodel.userAuthenticated
              ? Material(
                color: DSColors.transparent,
                borderRadius: BorderRadius.circular(DSSpacing.xs.value),
                elevation: 3,
                child: DSPrimaryButton(
                  onPressed: () {
                    context.go(AppRouters.createNews);
                  },
                  label: HomeStrings.addNews.label,
                  trailingIcon: Icon(
                    Icons.add,
                    color: DSColors.neutralMediumWave,
                    size: DSSpacing.lg.value,
                  ),
                ),
              )
              : null,
    );
  }
}
