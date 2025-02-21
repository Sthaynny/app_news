import 'package:app_news/features/shared/auth/domain/models/user_model.dart';

final tMapUserModel = <String, dynamic>{
    'uid': '12345',
    'email': 'test@example.com',
    'displayName': 'Test User',
    'photoURL': 'http://example.com/photo.jpg',
    'emailVerified': true,
    'phoneNumber': '1234567890',
  };
  final tInstanceUserModel = UserModel.fromMap(tMapUserModel);
