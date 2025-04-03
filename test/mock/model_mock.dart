import 'package:ufersa_hub/features/shared/auth/domain/models/user_model.dart';
import 'package:ufersa_hub/features/shared/news/domain/enums/category_news.dart';
import 'package:ufersa_hub/features/shared/news/domain/models/news_model.dart';

final tMapUserModel = <String, dynamic>{
  'uid': '12345',
  'email': 'test@example.com',
  'displayName': 'Test User',
  'photoURL': 'http://example.com/photo.jpg',
  'emailVerified': true,
  'phoneNumber': '1234567890',
};
final tInstanceUserModel = UserModel.fromMap(tMapUserModel);

final tMapNewsModel = <String, dynamic>{
  'uid': '1',
  'title': 'Test Title',
  'description': 'Test Description',
  'publishedAt': '2023-10-01T00:00:00Z',
  'imagesUrl': ['https://example.com/image.jpg'],
};

final tInstanceNewsModel = NewsModel(
  uid: '',
  title: 'title',
  description: 'description',
  images: [],
  publishedAt: DateTime.now(),
  categoryNews: CategoryNews.other,
);
