import 'package:app_news/core/utils/commands.dart';
import 'package:app_news/core/utils/result.dart';

class LoginViewmodel {
  LoginViewmodel() {
    login = CommandAction<void, (String email, String password)>(_login);
  }
  late CommandAction login;

  Future<Result<void>> _login((String, String) credentials) async {
    return Result.ok();
  }
}
