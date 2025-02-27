import 'package:app_news/core/utils/commands.dart';
import 'package:app_news/core/utils/result.dart';
import 'package:app_news/features/shared/auth/data/repositories/auth_repository.dart';

class HomeViewModel {
  final AuthRepository _repository;

  HomeViewModel({required AuthRepository repository})
    : _repository = repository {
    logout = CommandBase<void>(_logout);
    authenticated = CommandBase<bool>(_authenticated);
  }

  late final CommandBase logout;
  late final CommandBase authenticated;
  // late final CommandAction<void, >

  Future<Result<void>> _logout() async {
    final result = await _repository.logout();

    return result;
  }

  Future<Result<bool>> _authenticated() async {
    final result = await _repository.isAuthenticated;

    return Result.ok(result);
  }
}
