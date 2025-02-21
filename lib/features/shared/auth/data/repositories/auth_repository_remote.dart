import 'package:app_news/core/utils/result.dart';
import 'package:app_news/features/shared/auth/data/repositories/auth_repository.dart';
import 'package:app_news/features/shared/auth/data/services/auth_service.dart';

class AuthRepositoryRemote extends AuthRepository {
  final AuthService _service;

  AuthRepositoryRemote({required AuthService service}) : _service = service;

  @override
  // TODO: implement isAuthenticated
  Future<bool> get isAuthenticated => throw UnimplementedError();

  @override
  Future<Result<void>> login({required String email, required String password}) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
