import 'package:app_news/features/shared/news/domain/models/news_model.dart';

class DetailsNewsArgs {
  final NewsModel news;
  final bool isAuthenticated;

  DetailsNewsArgs({required this.news, required this.isAuthenticated});
}
