import 'package:app_news/core/utils/result.dart';
import 'package:app_news/features/shared/auth/data/repositories/auth_repository.dart';
import 'package:app_news/features/shared/auth/data/repositories/auth_repository_remote.dart';
import 'package:app_news/features/shared/auth/data/services/auth_service.dart';
import 'package:app_news/features/shared/auth/domain/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAuthService extends Mock implements AuthService {}

void main() {
  late AuthRepository repository;
  late MockAuthService service;
  const email = 'test@example.com';
  const password = 'wrongpassword';

  setUp(() {
    service = MockAuthService();
    repository = AuthRepositoryRemote(service: service);
  });

  group('AuthRepository Tests', () {
    test('should return true when user is authenticated', () async {
      when(repository.isAuthenticated).thenAnswer((_) async => true);

      final result = await repository.isAuthenticated;

      expect(result, true);
    });
    group('Login', () {
      test('should return false when user is not authenticated', () async {
        when(repository.isAuthenticated).thenAnswer((_) async => true);

        final result = await repository.isAuthenticated;

        expect(result, true);
      });

      test('should login successfully', () async {
        when(service.signInWithEmailAndPassword(email, password)).thenAnswer(
          (_) async => UserModel(
            uid: 'uid',
            email: 'email',
            displayName: 'displayName',
            photoURL: 'photoURL',
          ),
        );

        final result = await repository.login(email: email, password: password);

        expect(result is Ok, true);
      });

      test('should fail to login with incorrect credentials', () async {
        when(service.signInWithEmailAndPassword(email, password)).thenAnswer(
          (_) async =>
              throw FirebaseAuthException(
                message: 'Invalid credentials',
                code: 'invalid-credentials',
              ),
        );

        final result = await repository.login(email: email, password: password);

        expect(result is Ok, false);
        expect((result as Error).error, 'Invalid credentials');
      });

      test('should logout successfully', () async {
        when(repository.logout()).thenAnswer((_) async => Result.ok(null));

        final result = await repository.logout();

        expect(result is Ok, true);
      });
    });
  });
  group('Logout', () {
    test('should return false when user is not authenticated', () async {
      when(repository.isAuthenticated).thenAnswer((_) async => false);

      final result = await repository.isAuthenticated;

      expect(result, false);
    });

    test('should logout successfully', () async {
      when(service.signOut()).thenAnswer((_) async {});

      final result = await repository.login(email: email, password: password);

      expect(result is Ok, true);
    });

    test('should logout with Error', () async {
      when(service.signOut()).thenAnswer((_) async => throw Exception());

      final result = await repository.logout();

      expect(result is Error, true);
    });
  });
}
