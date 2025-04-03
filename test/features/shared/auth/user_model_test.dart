import 'package:ufersa_hub/features/shared/auth/domain/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock/model_mock.dart';

void main() {
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
