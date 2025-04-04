import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ufersa_hub/core/firebase/collections.dart';
import 'package:ufersa_hub/features/events/domain/models/events_model.dart';
import 'package:ufersa_hub/features/events/domain/models/filter_events_model.dart';

class EventsService {
  final firebase = FirebaseFirestore.instance;

  Future<void> createEvents(EventsModel model) async {
    try {
      await firebase.collection(Collections.events.name).add(model.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateEvents(EventsModel model) async {
    try {
      await firebase
          .collection(Collections.events.name)
          .doc(model.uid)
          .update(model.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteEvents(String uid) async {
    try {
      await firebase.collection(Collections.events.name).doc(uid).delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<EventsModel>> getEvents({
    Documents? orderBy,
    bool descending = false,
    FilterEventsModel? filter,
  }) async {
    try {
      Query colection = firebase.collection(Collections.events.name);
      // if (filter != null) {
      //   if (filter.categories.isNotEmpty) {
      //     colection = colection.where(
      //       'category',
      //       whereIn: filter.categories.map((e) => e.name).toList(),
      //     );
      //   }
      // }

      final response =
          await (orderBy != null && filter == null
              ? colection.orderBy(orderBy.name, descending: true).get()
              : colection.get());
      return response.docs.map((e) {
        return EventsModel.fromMap({
          'uid': e.id,
          if (e.data() != null) ...e.data() as Map<String, dynamic>,
        });
      }).toList();
    } catch (e) {
      rethrow;
    }
  }
}
