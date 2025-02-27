import 'package:app_news/core/strings/strings.dart';
import 'package:app_news/core/utils/result.dart';
import 'package:app_news/features/shared/news/data/repositories/news_respository.dart';
import 'package:app_news/features/shared/news/data/services/news_service.dart';
import 'package:app_news/features/shared/news/domain/models/news_model.dart';

class NewsRespositoryRemote implements NewsRespository {
  final NewsService _service;

  NewsRespositoryRemote({required NewsService service}) : _service = service;
  @override
  Future<Result<void>> createNews(NewsModel model) async {
    try {
      await _service.createNews(model);
      return Result.ok();
    } on Exception catch (e) {
      return Result.error(e);
    } catch (e) {
      return Result.errorDefault(StringsApp.errorDefault.label);
    }
  }

  @override
  Future<Result<void>> deleteNews(String uid) async {
    try {
      await _service.deleteNews(uid);
      return Result.ok();
    } on Exception catch (e) {
      return Result.error(e);
    } catch (e) {
      return Result.errorDefault(StringsApp.errorDefault.label);
    }
  }

  @override
  Future<Result<List<NewsModel>>> getNews() async {
    try {
      final response = await _service.getNews();
      return Result.ok(response);
    } on Exception catch (e) {
      return Result.error(e);
    } catch (e) {
      return Result.errorDefault(StringsApp.errorDefault.label);
    }
  }

  @override
  Future<Result<void>> updateNews(NewsModel model) async {
    try {
      await _service.updateNews(model);
      return Result.ok();
    } on Exception catch (e) {
      return Result.error(e);
    } catch (e) {
      return Result.errorDefault(StringsApp.errorDefault.label);
    }
  }
}
