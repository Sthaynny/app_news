import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ufersa_hub/core/firebase/collections.dart';
import 'package:ufersa_hub/features/news/filter/domain/models/filter_news_model.dart';
import 'package:ufersa_hub/features/shared/news/domain/models/news_model.dart';

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
    FilterNewsModel? filter,
  }) async {
    try {
      Query colection = firebase.collection(Collections.news.name);
      if (filter != null) {
        if (filter.categories.isNotEmpty) {
          colection = colection.where(
            'category',
            whereIn: filter.categories.map((e) => e.name).toList(),
          );
        }

        if (filter.course.isNotEmpty) {
          colection = colection.where(
            'course',
            whereIn: filter.course.map((e) => e.name).toList(),
          );
        }
      }

      final response =
          await (orderBy != null && filter == null
              ? colection.orderBy(orderBy.name, descending: true).get()
              : colection.get());
      return response.docs.map((e) {
        return NewsModel.fromMap({
          'uid': e.id,
          if (e.data() != null) ...e.data() as Map<String, dynamic>,
        });
      }).toList();
    } catch (e) {
      rethrow;
    }
  }
}
