import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ufersa_hub/core/firebase/collections.dart';
import 'package:ufersa_hub/features/shared/firebase/domain/filter_firebase_model.dart';
import 'package:ufersa_hub/features/shared/firebase/domain/firebase_model.dart';

class FirebaseService {
  final firebase = FirebaseFirestore.instance;

  Future<void> create<T extends FirebaseModel>(
    T model, {
    required Collections collection,
  }) async {
    try {
      await firebase.collection(collection.name).add(model.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> update<T extends FirebaseModel>(
    T model, {
    required Collections collection,
  }) async {
    try {
      await firebase
          .collection(collection.name)
          .doc(model.uid)
          .update(model.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> delete(String uid, {required Collections collection}) async {
    try {
      await firebase.collection(collection.name).doc(uid).delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<T>> get<T extends FirebaseModel>({
    Documents? orderBy,
    bool descending = false,
    FilterFirebaseModel? filter,
    required Collections collection,
    required T Function(Map<String, dynamic>) mapper,
  }) async {
    try {
      Query colection = firebase.collection(collection.name);
      if (filter != null) {
        colection = filter.applyFilter(colection);
      }

      final response =
          await (orderBy != null && filter == null
              ? colection.orderBy(orderBy.name, descending: true).get()
              : colection.get());
      return response.docs.map((e) {
        return mapper({
          'uid': e.id,
          if (e.data() != null) ...e.data() as Map<String, dynamic>,
        });
      }).toList();
    } catch (e) {
      rethrow;
    }
  }
}
