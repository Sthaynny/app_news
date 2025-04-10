import 'package:ufersa_hub/core/strings/strings.dart';
import 'package:ufersa_hub/core/utils/result.dart';
import 'package:ufersa_hub/features/shared/auth/data/repositories/auth_repository.dart';
import 'package:ufersa_hub/features/shared/auth/data/services/auth_service.dart';
import 'package:ufersa_hub/features/shared/auth/domain/models/user_model.dart';

class AuthRepositoryRemote extends AuthRepository {
  final AuthService _service;

  AuthRepositoryRemote({required AuthService service}) : _service = service;

  @override
  Future<bool> get isAuthenticated async => _service.getCurrentUser() != null;

  @override
  Future<Result<UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _service.signInWithEmailAndPassword(email, password);
      return result != null
          ? Result.ok(result)
          : Result.errorDefault(credenciaisInvalidasString);
    } on Exception catch (e) {
      return Result.error(e);
    } catch (e) {
      return Result.errorDefault(e.toString());
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      await _service.signOut();
      return Result.ok();
    } on Exception catch (e) {
      return Result.error(e);
    } catch (e) {
      return Result.errorDefault(e.toString());
    }
  }

  @override
  Future<Result<void>> fourgoutPassword(String email) async {
    try {
      await _service.fourgoutPassword(email);
      return Result.ok();
    } on Exception catch (e) {
      return Result.error(e);
    } catch (e) {
      return Result.errorDefault(e.toString());
    }
  }
}
