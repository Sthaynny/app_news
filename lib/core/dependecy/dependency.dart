import 'package:get_it/get_it.dart';
import 'package:ufersa_hub/core/utils/permission/premission_service.dart';
import 'package:ufersa_hub/features/events/data/repositories/events_repository.dart';
import 'package:ufersa_hub/features/events/data/repositories/events_repository_remote.dart';
import 'package:ufersa_hub/features/events/data/services/events_service.dart';
import 'package:ufersa_hub/features/login/screen/login_viewmodel.dart';
import 'package:ufersa_hub/features/shared/auth/data/repositories/auth_repository.dart';
import 'package:ufersa_hub/features/shared/auth/data/repositories/auth_repository_remote.dart';
import 'package:ufersa_hub/features/shared/auth/data/services/auth_service.dart';
import 'package:ufersa_hub/features/shared/news/data/repositories/news_repository.dart';
import 'package:ufersa_hub/features/shared/news/data/repositories/news_repository_remote.dart';
import 'package:ufersa_hub/features/shared/news/data/services/news_service.dart';

final dependency = GetIt.instance;

void setup() {
  dependency.registerFactory<AuthService>(() => AuthService());
  dependency.registerFactory<AuthRepository>(
    () => AuthRepositoryRemote(service: dependency()),
  );
  dependency.registerFactory(() => LoginViewModel(repository: dependency()));

  dependency.registerFactory<NewsService>(NewsService.new);

  dependency.registerFactory<NewsRepository>(
    () => NewsRepositoryRemote(service: dependency()),
  );

  dependency.registerFactory(PermissionService.new);

  dependency.registerFactory(EventsService.new);

  dependency.registerFactory<EventsRepository>(
    () => EventsRepositoryRemote(service: dependency()),
  );
}
