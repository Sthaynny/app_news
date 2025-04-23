import 'package:ufersa_hub/core/utils/result.dart';
import 'package:ufersa_hub/features/events/domain/models/events_model.dart';

abstract class EventsRepository {
  Future<Result<List<EventsModel>>> getEvents();
  Future<Result<void>> createEvents(EventsModel model);
  Future<Result<void>> updateEvents(EventsModel model);
  Future<Result<void>> deleteEvents(String uid);
}
