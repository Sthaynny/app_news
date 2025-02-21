import 'package:app_news/core/utils/result.dart';

abstract class AuthRepository {
  Future<bool> get isAuthenticated;

  /// Perform login
  Future<Result<void>> login({required String email, required String password});

  /// Perform logout
  Future<Result<void>> logout();
}
