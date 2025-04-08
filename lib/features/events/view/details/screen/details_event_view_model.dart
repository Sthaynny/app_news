import 'package:ufersa_hub/core/utils/commands.dart';
import 'package:ufersa_hub/core/utils/result.dart';
import 'package:ufersa_hub/features/events/data/repositories/events_repository.dart';
import 'package:ufersa_hub/features/events/domain/models/events_model.dart';

class DetailsEventViewmodel {
  DetailsEventViewmodel({
    required EventsRepository repository,
    required EventsModel event,
    required this.isAuthenticated,
  }) : _repository = repository {
    _event = event;
    updateScreen = CommandAction<void, EventsModel>(_updateNews);
    deleteEvent = CommandAction<void, String>(_repository.deleteEvents);
  }
  late final CommandAction<void, EventsModel> updateScreen;
  late final CommandAction<void, String> deleteEvent;

  late EventsModel _event;
  final bool isAuthenticated;
  final EventsRepository _repository;
  EventsModel get event => _event;

  String? get imagesBase64 => _event.image;

  Future<Result<void>> _updateNews(EventsModel event) async {
    _event = event;

    return Result.ok();
  }
}
