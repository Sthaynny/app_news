import 'package:flutter_test/flutter_test.dart';
import 'package:ufersa_hub/features/shared/news/domain/models/news_model.dart';

import '../../../mock/model_mock.dart';

void main() {
  test('Deve retornar uma instancia de NewsModel ', () {
    expect(tInstanceNewsModel, isA<NewsModel>());
  });

  test('Deve retornar um modelo valido(Map)', () {
    final result = NewsModel.fromMap(tMapNewsModel);

    expect(result, isA<NewsModel>());
  });

  test('Deve retornar um Map', () {
    final result = tInstanceNewsModel.toMap();

    expect(result, tMapNewsModel);
  });
}
