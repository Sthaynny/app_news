import 'package:ufersa_hub/core/router/app_router.dart';
import 'package:ufersa_hub/core/strings/strings.dart';
import 'package:ufersa_hub/core/utils/extension/build_context.dart';
import 'package:ufersa_hub/features/home/screen/components/app_drawer.dart';
import 'package:ufersa_hub/features/home/screen/components/card_news_widget.dart';
import 'package:ufersa_hub/features/home/screen/home_view_model.dart';
import 'package:ufersa_hub/features/home/utils/home_strings.dart';
import 'package:ufersa_hub/features/news/filter/screen/filter_screen.dart';
import 'package:ufersa_hub/features/news/filter/screen/filter_view_model.dart';
import 'package:ufersa_hub/features/shared/components/news_app_bar.dart';
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
      viewmodel.news.execute((true, null));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewsAppBar(
        isLongPress: true,
        leading: Builder(
          builder: (context) {
            return DSIconButton(
              key: Key('menu_button'),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: DSIcons.menu_dot_outline,
            );
          },
        ),
        actions: [
          DSIconButton(
            onPressed: () async {
              final result = await showModalBottomSheet(
                context: context,
                builder:
                    (context) => FilterScreen(
                      viewModel: FilterViewModel(filter: viewmodel.filterNews),
                    ),
              );

              if (result != null) {
                if (result is bool) {
                  viewmodel.news.execute((true, null));
                  return;
                } else {
                  viewmodel.news.execute((true, result));
                }
              }
            },
            icon: DSIcons.filter_outline,
          ),
        ],
      ),
      drawer: AppDrawer(viewmodel: viewmodel),
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
                  onAction: () {
                    viewmodel.news.execute((true, null));
                  },
                );
              },
            );
          }
          if (viewmodel.news.error && viewmodel.newsList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DSSpacing.xl.y,
                  DSHeadlineLargeText(HomeStrings.error.label),
                  DSSpacing.xl.y,
                  DSPrimaryButton(
                    label: tenteNovamenteString,
                    onPressed: () => viewmodel.news.execute((true, null)),
                  ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: ListenableBuilder(
        listenable: viewmodel.authenticated,
        builder:
            (context, child) =>
                viewmodel.userAuthenticated
                    ? Material(
                      color: DSColors.transparent,
                      borderRadius: BorderRadius.circular(DSSpacing.xs.value),
                      elevation: 3,
                      child: DSPrimaryButton(
                        onPressed: () {
                          context.go(AppRouters.manegerNews);
                        },
                        label: HomeStrings.addNews.label,
                        trailingIcon: Icon(
                          Icons.add,
                          color: DSColors.neutralMediumWave,
                          size: DSSpacing.lg.value,
                        ),
                      ),
                    )
                    : Container(),
      ),
    );
  }
}
