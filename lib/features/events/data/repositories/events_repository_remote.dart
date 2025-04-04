import 'package:ufersa_hub/core/firebase/collections.dart';
import 'package:ufersa_hub/core/utils/request/request_mixin.dart';
import 'package:ufersa_hub/core/utils/result.dart';
import 'package:ufersa_hub/features/events/data/repositories/events_repository.dart';
import 'package:ufersa_hub/features/events/data/services/events_service.dart';
import 'package:ufersa_hub/features/events/domain/models/events_model.dart';

class EventsRepositoryRemote with RequestMixin implements EventsRepository {
  final EventsService _service;

  EventsRepositoryRemote({required EventsService service}) : _service = service;
  @override
  Future<Result<void>> createEvents(EventsModel model) async {
    return request(() async {
      await _service.createEvents(model);
    });
  }

  @override
  Future<Result<void>> deleteEvents(String uid) async {
    return request(() async {
      await _service.deleteEvents(uid);
    });
  }

  @override
  Future<Result<List<EventsModel>>> getEvents() async {
    return request<List<EventsModel>>(() async {
      final response = await _service.getEvents(
        orderBy: Documents.start,
        descending: true,
      );
      return response;
    });
  }

  @override
  Future<Result<void>> updateEvents(EventsModel model) async {
    return request(() async {
      await _service.updateEvents(model);
    });
  }
}
