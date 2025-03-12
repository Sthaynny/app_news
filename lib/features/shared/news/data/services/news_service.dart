import 'package:app_news/core/firebase/collections.dart';
import 'package:app_news/features/shared/news/domain/models/news_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewsService {
  final firebase = FirebaseFirestore.instance;

  Future<void> createNews(NewsModel model) async {
    try {
      await firebase.collection(Collections.news.name).add(model.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateNews(NewsModel model) async {
    try {
      await firebase
          .collection(Collections.news.name)
          .doc(model.uid)
          .update(model.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteNews(String uid) async {
    try {
      await firebase.collection(Collections.news.name).doc(uid).delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<NewsModel>> getNews({
    Documents? orderBy,
    bool descending = false,
  }) async {
    try {
      final colection = firebase.collection(Collections.news.name);
      final response =
          await (orderBy != null
              ? colection.orderBy(orderBy.name, descending: true).get()
              : colection.get());
      return response.docs
          .map((e) => NewsModel.fromMap({'uid': e.id, ...e.data()}))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
