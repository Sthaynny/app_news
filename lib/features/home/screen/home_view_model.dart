import 'package:app_news/core/utils/commands.dart';
import 'package:app_news/core/utils/result.dart';
import 'package:app_news/features/shared/auth/data/repositories/auth_repository.dart';
import 'package:app_news/features/shared/news/data/repositories/news_repository.dart';
import 'package:app_news/features/shared/news/domain/models/news_model.dart';

class HomeViewModel {
  final AuthRepository _authRepository;
  final NewsRepository _newsRepository;

  late final CommandBase logout;
  late final CommandBase authenticated;
  late final CommandAction<List<NewsModel>, bool?> news;

  HomeViewModel({
    required AuthRepository authRepository,
    required NewsRepository newsRepository,
  }) : _authRepository = authRepository,
       _newsRepository = newsRepository {
    logout = CommandBase<void>(_logout);
    authenticated = CommandBase<bool>(_authenticated);
    news = CommandAction<List<NewsModel>, bool?>(_getNews);
  }

  /// Variaveis de dados
  final _newsList = <NewsModel>[];
  bool _userAuthenticated = false;
  bool get userAuthenticated => _userAuthenticated;
  List<NewsModel> get newsList => _newsList;
  Future<Result<void>> _logout() async {
    final result = await _authRepository.logout();
    await _authenticated();
    return result;
  }

  Future<Result<bool>> _authenticated() async {
    final result = await _authRepository.isAuthenticated;
    _userAuthenticated = result;

    return Result.ok(result);
  }

  Future<Result<List<NewsModel>>> _getNews([bool? restart]) async {
    final result = await _newsRepository.getNews();

    switch (result) {
      case Ok _:
        restart ??= false;
        if (restart) {
          newsList.clear();
        }

        newsList.addAll(result.value as List<NewsModel>);
        break;
      case Error _:
        return result;
    }
    return result;
  }
}
