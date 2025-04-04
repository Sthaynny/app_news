import 'package:ufersa_hub/core/utils/commands.dart';
import 'package:ufersa_hub/features/events/data/repositories/events_repository.dart';
import 'package:ufersa_hub/features/events/domain/models/events_model.dart';

class EventsViewModel {
  final EventsRepository _eventsRepository;

  late final CommandBase<List<EventsModel>> getEvents;

  EventsViewModel({required EventsRepository eventsRepository})
    : _eventsRepository = eventsRepository {
    getEvents = CommandBase<List<EventsModel>>(
      () => _eventsRepository.getEvents(),
    );
  }
}
