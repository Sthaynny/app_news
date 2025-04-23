import 'package:ufersa_hub/core/utils/commands.dart';
import 'package:ufersa_hub/core/utils/result.dart';
import 'package:ufersa_hub/features/events/domain/repositories/events_repository.dart';
import 'package:ufersa_hub/features/events/domain/models/events_model.dart';
import 'package:ufersa_hub/features/shared/auth/data/repositories/auth_repository.dart';

class EventsViewModel {
  final EventsRepository _eventsRepository;

  late final CommandBase<List<EventsModel>> getEvents;

  late final CommandBase authenticated;

  EventsViewModel({
    required EventsRepository eventsRepository,
    required AuthRepository authRepository,
  }) : _eventsRepository = eventsRepository {
    getEvents = CommandBase<List<EventsModel>>(
      () => _eventsRepository.getEvents(),
    );

    authenticated = CommandBase<bool>(() async {
      final result = await authRepository.isAuthenticated;
      _userAuthenticated = result;

      return Result.ok(result);
    });
  }
  bool _userAuthenticated = false;

  bool get userAuthenticated => _userAuthenticated;
}
