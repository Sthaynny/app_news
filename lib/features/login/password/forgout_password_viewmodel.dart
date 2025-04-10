import 'package:ufersa_hub/core/utils/commands.dart';
import 'package:ufersa_hub/features/shared/auth/data/repositories/auth_repository.dart';

class ForgoutPasswordViewmodel {
  ForgoutPasswordViewmodel({required AuthRepository authRepository}) {
    forgoutPassword = CommandAction(authRepository.fourgoutPassword);
  }

  late CommandAction<void, String> forgoutPassword;
}
