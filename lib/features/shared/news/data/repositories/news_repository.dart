import 'package:app_news/core/utils/result.dart';
import 'package:app_news/features/news/filter/domain/models/filter_news_model.dart';
import 'package:app_news/features/shared/news/domain/models/news_model.dart';

abstract class NewsRepository {
  Future<Result<List<NewsModel>>> getNews([FilterNewsModel? filter]);
  Future<Result<void>> createNews(NewsModel model);
  Future<Result<void>> updateNews(NewsModel model);
  Future<Result<void>> deleteNews(String uid);
}
