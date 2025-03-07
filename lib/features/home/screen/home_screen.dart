import 'package:app_news/core/strings/strings.dart';
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
    viewmodel.news.addListener(_onResult);
    viewmodel.news.execute();
    // viewmodel.authenticated.execute();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewmodel.news.removeListener(_onResult);
    viewmodel.news.addListener(_onResult);
  }

  @override
  void dispose() {
    viewmodel.news.removeListener(_onResult);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewsAppBar(isLongPress: true),
      body: ListenableBuilder(
        listenable: viewmodel.news,
        builder: (_, __) {
          if (viewmodel.news.completed) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  DSSpacing.md.y,
                  Card(
                    child: ListTile(
                      title: DSHeadlineLargeText("Title"),
                      subtitle: DSBodyText("Subtitle"),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  void _onResult() {
    if (viewmodel.news.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(HomeStrings.error.label),
          action: SnackBarAction(
            label: StringsApp.tenteNovamente.label,
            onPressed: () {},
          ),
        ),
      );
    }
  }
}
