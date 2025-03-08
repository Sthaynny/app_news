import 'package:app_news/core/utils/request/request_mixin.dart';
import 'package:app_news/core/utils/result.dart';
import 'package:app_news/features/shared/news/data/repositories/news_repository.dart';
import 'package:app_news/features/shared/news/data/services/news_service.dart';
import 'package:app_news/features/shared/news/domain/models/news_model.dart';

class NewsRepositoryRemote with RequestMixin implements NewsRepository {
  final NewsService _service;

  NewsRepositoryRemote({required NewsService service}) : _service = service;
  @override
  Future<Result<void>> createNews(NewsModel model) async {
    return request(() async {
      await _service.createNews(model);
    });
  }

  @override
  Future<Result<void>> deleteNews(String uid) async {
    return request(() async {
      await _service.deleteNews(uid);
    });
  }

  @override
  Future<Result<List<NewsModel>>> getNews() async {
    return request<List<NewsModel>>(() async {
      final response = await _service.getNews();
      return response;
    });
  }

  @override
  Future<Result<void>> updateNews(NewsModel model) async {
    return request(() async {
      await _service.updateNews(model);
    });
  }
}
