import 'package:ufersa_hub/core/firebase/collections.dart';
import 'package:ufersa_hub/core/utils/result.dart';
import 'package:ufersa_hub/features/shared/news/data/repositories/news_repository_remote.dart';
import 'package:ufersa_hub/features/shared/news/data/services/news_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mock/model_mock.dart';

class NewsServiceMock extends Mock implements NewsService {}

void main() {
  late NewsService service;
  late NewsRepositoryRemote repository;

  setUpAll(() {
    service = NewsServiceMock();
    repository = NewsRepositoryRemote(service: service);
    registerFallbackValue(tInstanceNewsModel);
  });

  group('NewsRepository Tests', () {
    group('getNews', () {
      test('should return news list', () async {
        when(
          () =>
              service.getNews(orderBy: Documents.publishedAt, descending: true),
        ).thenAnswer((_) async => []);

        final result = await repository.getNews();

        expect(result.isOk, true);
      });

      test('should return error', () async {
        when(
          () =>
              service.getNews(orderBy: Documents.publishedAt, descending: true),
        ).thenThrow(Exception('error'));

        final result = await repository.getNews();

        expect(result.isError, true);
      });
    });

    group('updateNews', () {
      test('should update news', () async {
        when(() => service.updateNews(any())).thenAnswer((_) async {});

        final result = await repository.updateNews(tInstanceNewsModel);

        expect(result.isOk, true);
      });

      test('should return error', () async {
        when(() => service.updateNews(any())).thenThrow(Exception('error'));

        final result = await repository.updateNews(tInstanceNewsModel);

        expect(result.isError, true);
      });
    });

    group('createNews', () {
      test('should create news', () async {
        when(() => service.createNews(any())).thenAnswer((_) async {});

        final result = await repository.createNews(tInstanceNewsModel);

        expect(result.isOk, true);
      });

      test('should return error', () async {
        when(() => service.createNews(any())).thenThrow(Exception('error'));

        final result = await repository.createNews(tInstanceNewsModel);

        expect(result.isError, true);
      });
    });
    group('deleteNews', () {
      test('should delete news', () async {
        when(() => service.deleteNews(any())).thenAnswer((_) async {});

        final result = await repository.deleteNews(tInstanceNewsModel.uid);

        expect(result.isOk, true);
      });

      test('should return error', () async {
        when(() => service.deleteNews(any())).thenThrow(Exception('error'));

        final result = await repository.deleteNews(tInstanceNewsModel.uid);

        expect(result.isError, true);
      });
    });
  });
}
