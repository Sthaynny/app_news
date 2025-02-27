import 'package:app_news/core/utils/result.dart';
import 'package:app_news/features/login/screen/login_viewmodel.dart';
import 'package:app_news/features/shared/auth/data/repositories/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRepoAuth extends Mock implements AuthRepository {}

void main() {
  final repository = MockRepoAuth();
  late LoginViewModel viewModel;

  setUpAll(() {
    viewModel = LoginViewModel(repository: repository);
  });

  group('LoginViewModel Tests', () {
    test('should return ok when login is successful', () async {
      when(
        () => repository.login(email: '', password: ''),
      ).thenAnswer((_) async => Result.ok());

      expect(viewModel.login.completed, false);

      await viewModel.login.execute(('', ''));

      expect(viewModel.login.completed, true);
      expect(viewModel.login.result?.isOk, true);
    });
    test('should return ok when login is error', () async {
      when(
        () => repository.login(email: '', password: ''),
      ).thenAnswer((_) async => Result.errorDefault(''));

      await viewModel.login.execute(('', ''));

      expect(viewModel.login.error, isTrue);
    });
  });
}
