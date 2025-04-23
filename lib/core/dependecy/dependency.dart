import 'package:get_it/get_it.dart';
import 'package:ufersa_hub/core/utils/permission/premission_service.dart';
import 'package:ufersa_hub/features/documents/data/repositories/documents_repository.dart';
import 'package:ufersa_hub/features/documents/domain/repositories/documents_repository.dart';
import 'package:ufersa_hub/features/documents/view/maneger/maneger_document_viewmodel.dart';
import 'package:ufersa_hub/features/documents/view/page/documents_view_model.dart';
import 'package:ufersa_hub/features/events/data/repositories/events_repository_remote.dart';
import 'package:ufersa_hub/features/events/data/services/events_service.dart';
import 'package:ufersa_hub/features/events/domain/repositories/events_repository.dart';
import 'package:ufersa_hub/features/events/view/maneger/maneger_events_view_model.dart';
import 'package:ufersa_hub/features/events/view/page/events_view_model.dart';
import 'package:ufersa_hub/features/login/password/forgout_password_viewmodel.dart';
import 'package:ufersa_hub/features/login/screen/login_viewmodel.dart';
import 'package:ufersa_hub/features/shared/auth/data/repositories/auth_repository.dart';
import 'package:ufersa_hub/features/shared/auth/data/repositories/auth_repository_remote.dart';
import 'package:ufersa_hub/features/shared/auth/data/services/auth_service.dart';
import 'package:ufersa_hub/features/shared/firebase/data/service/firebase_service.dart';
import 'package:ufersa_hub/features/shared/news/data/repositories/news_repository.dart';
import 'package:ufersa_hub/features/shared/news/data/repositories/news_repository_remote.dart';
import 'package:ufersa_hub/features/shared/news/data/services/news_service.dart';

final dependency = GetIt.instance;

void setup() {
  dependency.registerFactory<AuthService>(AuthService.new);
  dependency.registerFactory<FirebaseService>(FirebaseService.new);
  dependency.registerFactory<AuthRepository>(
    () => AuthRepositoryRemote(service: dependency()),
  );
  dependency.registerFactory(() => LoginViewModel(repository: dependency()));
  dependency.registerFactory(
    () => ForgoutPasswordViewmodel(authRepository: dependency()),
  );

  dependency.registerFactory<NewsService>(NewsService.new);

  dependency.registerFactory<NewsRepository>(
    () => NewsRepositoryRemote(service: dependency()),
  );

  dependency.registerFactory(PermissionService.new);

  dependency.registerFactory(EventsService.new);

  dependency.registerFactory<EventsRepository>(
    () => EventsRepositoryRemote(service: dependency()),
  );

  dependency.registerFactory(
    () => EventsViewModel(
      eventsRepository: dependency(),
      authRepository: dependency(),
    ),
  );

  dependency.registerFactory(
    () => ManegerEventsViewmodel(
      repository: dependency(),
      permissionService: dependency(),
    ),
  );

  dependency.registerFactory<DocumentsRepository>(
    () => DocumentsRepositoryImpl(firebaseService: dependency()),
  );

  dependency.registerFactory(
    () => DocumentsViewModel(
      repository: dependency(),
      authRepository: dependency(),
    ),
  );

  dependency.registerFactory(
    () => ManegerDocumentViewmodel(repository: dependency()),
  );
}
