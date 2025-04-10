import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ufersa_hub/core/utils/permission/premission_service.dart';
import 'package:ufersa_hub/core/utils/result.dart';
import 'package:ufersa_hub/features/news/maneger/maneger_news_viewmodel.dart';
import 'package:ufersa_hub/features/shared/news/data/repositories/news_repository.dart';
import 'package:ufersa_hub/features/shared/news/domain/models/news_model.dart';

import '../../mock/model_mock.dart';

class MockPermission extends Mock implements PermissionService {}

class MockRepoNews extends Mock implements NewsRepository {}

void main() {
  final newsRepo = MockRepoNews();
  final permission = MockPermission();
  late ManegerNewsViewmodel viewModel;

  setUpAll(() {
    viewModel = ManegerNewsViewmodel(
      repository: newsRepo,
      permissionService: permission,
    );

    registerFallbackValue(tInstanceNewsModel);
  });

  group('ManegerNewsViewmodel Tests', () {
    group('getPermission', () {
      test('should return ok when getPermission is successful', () async {
        when(
          () => permission.isPermissionGranted(Permission.photos),
        ).thenAnswer((_) async => true);

        expect(viewModel.getPermission.completed, false);

        await viewModel.getPermission.execute();

        expect(viewModel.getPermission.completed, true);
        expect(viewModel.getPermission.result?.isOk, true);
      });
      test('should return ok when getPermission is true', () async {
        when(
          () => permission.isPermissionGranted(Permission.photos),
        ).thenAnswer((_) async => false);
        when(
          () => permission.requestPermission(Permission.photos),
        ).thenAnswer((_) async => true);

        await viewModel.getPermission.execute();

        expect(viewModel.getPermission.result?.value, isTrue);
      });
      test('should return ok when getPermission is false', () async {
        when(
          () => permission.isPermissionGranted(Permission.photos),
        ).thenAnswer((_) async => false);
        when(
          () => permission.requestPermission(Permission.photos),
        ).thenAnswer((_) async => false);

        await viewModel.getPermission.execute();

        expect(viewModel.getPermission.result?.value, isFalse);
      });
    });
    group('createNews', () {
      test('should return ok when createNews is successful', () async {
        when(
          () => newsRepo.createNews(any()),
        ).thenAnswer((_) async => Result.ok());

        expect(viewModel.createNews.completed, false);

        await viewModel.createNews.execute(
          NewsModel(
            title: tInstanceNewsModel.title,
            description: tInstanceNewsModel.description ?? '',
            categoryNews: tInstanceNewsModel.categoryNews,
            images: [],
            uid: '',
            publishedAt: DateTime.now(),
          ),
        );

        expect(viewModel.createNews.completed, true);
        expect(viewModel.createNews.result?.isOk, true);
      });
      test('should return ok when createNews is error', () async {
        when(
          () => newsRepo.createNews(any()),
        ).thenAnswer((_) async => Result.errorDefault(''));

        await viewModel.createNews.execute(
          NewsModel(
            title: tInstanceNewsModel.title,
            description: tInstanceNewsModel.description ?? '',
            categoryNews: tInstanceNewsModel.categoryNews,
            images: [],
            uid: '',
            publishedAt: DateTime.now(),
          ),
        );

        expect(viewModel.createNews.error, isTrue);
      });
    });
  });
}
