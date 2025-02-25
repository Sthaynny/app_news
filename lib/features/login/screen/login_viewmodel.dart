import 'package:app_news/core/utils/commands.dart';
import 'package:app_news/core/utils/result.dart';

class LoginViewModel {
  LoginViewModel() {
    login = CommandAction<void, (String email, String password)>(_login);
  }

  late CommandAction<void, (String email, String password)> login;
  Result? result;

  Future<Result<void>> _login((String, String) credentials) async {
    return Result.ok();
  }
}
