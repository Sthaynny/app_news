import 'package:app_news/features/login/screen/login_viewmodel.dart';
import 'package:app_news/features/shared/auth/data/repositories/auth_repository.dart';
import 'package:app_news/features/shared/auth/data/repositories/auth_repository_remote.dart';
import 'package:app_news/features/shared/auth/data/services/auth_service.dart';
import 'package:get_it/get_it.dart';

final dependency = GetIt.instance;

void setup() {
  dependency.registerFactory<AuthService>(() => AuthService());
  dependency.registerFactory<AuthRepository>(
    () => AuthRepositoryRemote(service: dependency()),
  );
  dependency.registerFactory(() => LoginViewModel(repository: dependency()));
}
