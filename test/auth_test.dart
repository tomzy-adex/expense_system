import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:expense_tracker/services/auth_service.dart';
import 'package:expense_tracker/viewmodels/auth_viewmodel.dart';

class MockAuthService extends Mock implements AuthService {}

class MockUserCredential extends Mock implements UserCredential {}

void main() {
  group('AuthViewModel Tests', () {
    late AuthViewModel authViewModel;
    late MockAuthService mockAuthService;
    late MockUserCredential mockUserCredential;

    setUp(() {
      mockAuthService = MockAuthService();
      mockUserCredential = MockUserCredential();
      authViewModel = AuthViewModel(mockAuthService);
    });

    test('Sign in with valid credentials should succeed', () async {
      when(mockAuthService.signIn('test@example.com', 'password'))
          .thenAnswer((_) async => mockUserCredential);

      await authViewModel.signIn('test@example.com', 'password');

      verify(mockAuthService.signIn('test@example.com', 'password')).called(1);
    });

    test('Register with valid credentials should succeed', () async {
      when(mockAuthService.register('test@example.com', 'password'))
          .thenAnswer((_) async => mockUserCredential);

      await authViewModel.register('test@example.com', 'password');

      verify(mockAuthService.register('test@example.com', 'password'))
          .called(1);
    });

    test('Sign out should succeed', () async {
      when(mockAuthService.signOut()).thenAnswer((_) async => null);

      await authViewModel.signOut();

      verify(mockAuthService.signOut()).called(1);
    });
  });
}
