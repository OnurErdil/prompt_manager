import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:prompt_manager/app/app.dart';
import 'package:prompt_manager/features/auth/domain/entities/app_user.dart';
import 'package:prompt_manager/features/auth/domain/repositories/auth_repository.dart';
import 'package:prompt_manager/features/auth/presentation/providers/auth_providers.dart';

void main() {
  testWidgets('App shell and router smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWith((ref) => _FakeAuthRepository()),
        ],
        child: const PromptManagerApp(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.text('Prompt çalışma sistemine giriş yap.'), findsOneWidget);
  });
}

class _FakeAuthRepository implements AuthRepository {
  @override
  AppUser? get currentUser => null;

  @override
  Stream<AppUser?> authStateChanges() => Stream.value(null);

  @override
  Future<AppUser> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return AppUser(id: 'test-user', email: email);
  }

  @override
  Future<AppUser> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return AppUser(id: 'test-user', email: email);
  }

  @override
  Future<void> signOut() async {}
}
