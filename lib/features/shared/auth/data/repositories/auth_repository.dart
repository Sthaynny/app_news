import 'package:ufersa_hub/core/utils/result.dart';
import 'package:ufersa_hub/features/shared/auth/domain/models/user_model.dart';

abstract class AuthRepository {
  Future<bool> get isAuthenticated;

  /// Perform login
  Future<Result<UserModel>> login({
    required String email,
    required String password,
  });

  /// Perform logout
  Future<Result<void>> logout();

  Future<Result<void>> fourgoutPassword(String email);
}
