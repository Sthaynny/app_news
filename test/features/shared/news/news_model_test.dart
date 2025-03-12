import 'dart:convert';

import 'package:app_news/features/shared/news/domain/models/news_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock/model_mock.dart';

void main() {
  

  test('Deve retornar uma instancia de NewsModel ', () {
    expect(tInstanceNewsModel, isA<NewsModel>());
  });

  test('Deve retornar um modelo valido(Json)', () {
    final result = NewsModel.fromJson(jsonEncode(tMapNewsModel));

    expect(result, isA<NewsModel>());
  });

  test('Deve retornar um modelo valido(Map)', () {
    final result = NewsModel.fromMap(tMapNewsModel);

    expect(result, isA<NewsModel>());
  });
  test('Deve retornar um Json', () {
    final result = tInstanceNewsModel.toJson();

    expect(result, jsonEncode(tInstanceNewsModel.toMap()));
  });

  test('Deve retornar um Map', () {
    final result = tInstanceNewsModel.toMap();

    expect(result, tMapNewsModel);
  });
}
