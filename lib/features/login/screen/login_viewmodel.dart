import 'package:app_news/core/strings/strings.dart';
import 'package:app_news/core/utils/commands.dart';
import 'package:app_news/core/utils/result.dart';
import 'package:app_news/features/shared/auth/data/repositories/auth_repository.dart';

class LoginViewModel {
  final AuthRepository _repository;

  late CommandAction<void, (String email, String password)> login;

  LoginViewModel({required AuthRepository repository})
    : _repository = repository {
    login = CommandAction<void, (String email, String password)>(_login);
  }

  Future<Result<void>> _login((String, String) credentials) async {
    final (email, password) = credentials;
    try {
      final result = await _repository.login(email: email, password: password);
      if (result.isOk) {
        return result;
      } else {
        return Result.errorDefault(credenciaisInvalidasString);
      }
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}
