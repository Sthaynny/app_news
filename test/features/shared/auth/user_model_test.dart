import 'package:app_news/features/shared/auth/domain/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMapUserModel = <String, dynamic>{
    'uid': '12345',
    'email': 'test@example.com',
    'displayName': 'Test User',
    'photoURL': 'http://example.com/photo.jpg',
    'emailVerified': true,
    'phoneNumber': '1234567890',
  };
  final tInstanceUserModel = UserModel.fromMap(tMapUserModel);

  test('Deve retornar uma instancia de  ', () {
    expect(tInstanceUserModel, isA<UserModel>());
  });

  test('Deve retornar um modelo valido(Map)', () {
    final result = UserModel.fromMap(tMapUserModel);

    expect(result, isA<UserModel>());
  });

  test('Deve retornar um Map', () {
    final result = tInstanceUserModel.toMap();

    expect(result, tMapUserModel);
  });
}
