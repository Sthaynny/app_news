import 'package:app_news/core/utils/result.dart';
import 'package:app_news/features/shared/news/domain/models/news_model.dart';

abstract class NewsRespository {
  Future<Result<List<NewsModel>>> getNews();
  Future<Result<void>> createNews(NewsModel model);
  Future<Result<void>> updateNews(NewsModel model);
  Future<Result<void>> deleteNews(String uid);
}
