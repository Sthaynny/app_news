import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FilterFirebaseModel {
  Query applyFilter(Query query);
}
