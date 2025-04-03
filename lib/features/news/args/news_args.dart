import 'package:ufersa_hub/features/shared/news/domain/models/news_model.dart';

class NewsArgs {
  final NewsModel news;
  final bool isAuthenticated;

  NewsArgs({required this.news, required this.isAuthenticated});
}
