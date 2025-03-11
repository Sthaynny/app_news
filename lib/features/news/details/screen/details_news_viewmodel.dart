import 'package:app_news/core/utils/commands.dart';
import 'package:app_news/core/utils/result.dart';
import 'package:app_news/features/shared/news/data/repositories/news_repository.dart';
import 'package:app_news/features/shared/news/domain/models/news_model.dart';

class DetailsNewsViewmodel {
  DetailsNewsViewmodel({
    required NewsRepository repository,
    required NewsModel news,
    required this.isAuthenticated,
  }) : _repository = repository {
    _news = news;
    updateScreen = CommandAction<void, NewsModel>(_updateNews);
    deleteNews = CommandAction<void, String>(_repository.deleteNews);
  }
  late final CommandAction<void, NewsModel> updateScreen;
  late final CommandAction<void, String> deleteNews;

  late NewsModel _news;
  final bool isAuthenticated;
  final NewsRepository _repository;
  NewsModel get news => _news;
  List<String> get imagesBase64 => _news.images;

  Future<Result<void>> _updateNews(NewsModel news) async {
    _news = news;

    return Result.ok();
  }
}
