import 'package:app_news/core/utils/commands.dart';
import 'package:app_news/core/utils/result.dart';
import 'package:app_news/features/shared/auth/data/repositories/auth_repository.dart';
import 'package:app_news/features/shared/news/data/repositories/news_repository.dart';

class HomeViewModel {
  final AuthRepository _authRepository;
  final NewsRepository _newsRepository;

  late final CommandBase logout;
  late final CommandBase authenticated;

  HomeViewModel({
    required AuthRepository authRepository,
    required NewsRepository newsRepository,
  }) : _authRepository = authRepository,
       _newsRepository = newsRepository {
    logout = CommandBase<void>(_logout);
    authenticated = CommandBase<bool>(_authenticated);
  }

  Future<Result<void>> _logout() async {
    final result = await _authRepository.logout();

    return result;
  }

  Future<Result<bool>> _authenticated() async {
    final result = await _authRepository.isAuthenticated;

    return Result.ok(result);
  }

  Future<Result<void>> getNews() async {
    final result = await _newsRepository.getNews();

    return result;
  }
}
