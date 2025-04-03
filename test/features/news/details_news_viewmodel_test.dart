import 'package:ufersa_hub/core/utils/result.dart';
import 'package:ufersa_hub/features/news/details/screen/details_news_viewmodel.dart';
import 'package:ufersa_hub/features/shared/auth/data/repositories/auth_repository.dart';
import 'package:ufersa_hub/features/shared/news/data/repositories/news_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock/model_mock.dart';

class MockRepoAuth extends Mock implements AuthRepository {}

class MockRepoNews extends Mock implements NewsRepository {}

void main() {
  final newsRepo = MockRepoNews();
  late DetailsNewsViewmodel viewModel;

  setUpAll(() {
    viewModel = DetailsNewsViewmodel(
      repository: newsRepo,
      news: tInstanceNewsModel,
      isAuthenticated: true,
    );
  });

  group('DetailsNewsViewmodel Tests', () {
    group('updateScreen', () {
      test('should return ok when updateScreen is successful', () async {
        expect(viewModel.updateScreen.completed, false);

        await viewModel.updateScreen.execute(tInstanceNewsModel);

        expect(viewModel.updateScreen.completed, true);
        expect(viewModel.updateScreen.result?.isOk, true);
      });
    });
    group('deleteNews', () {
      test('should return ok when deleteNews is successful', () async {
        when(
          () => newsRepo.deleteNews('123'),
        ).thenAnswer((_) async => Result.ok());

        expect(viewModel.deleteNews.completed, false);

        await viewModel.deleteNews.execute('123');

        expect(viewModel.deleteNews.completed, true);
        expect(viewModel.deleteNews.result?.isOk, true);
      });
      test('should return ok when deleteNews is error', () async {
        when(
          () => newsRepo.deleteNews('123'),
        ).thenAnswer((_) async => Result.errorDefault(''));

        await viewModel.deleteNews.execute('123');

        expect(viewModel.deleteNews.error, isTrue);
      });
    });
  });
}
