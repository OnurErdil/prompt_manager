import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:prompt_manager/app/router/route_names.dart';
import 'package:prompt_manager/features/auth/domain/entities/app_user.dart';
import 'package:prompt_manager/features/auth/domain/repositories/auth_repository.dart';
import 'package:prompt_manager/features/prompts/domain/entities/prompt_card.dart';
import 'package:prompt_manager/features/prompts/domain/enums/prompt_status.dart';
import 'package:prompt_manager/features/prompts/domain/repositories/prompt_repository.dart';
import 'package:prompt_manager/features/prompts/domain/services/prompt_variable_parser.dart';
import 'package:prompt_manager/features/prompts/presentation/controllers/prompt_edit_controller.dart';
import 'package:prompt_manager/features/prompts/presentation/providers/prompt_providers.dart';
import 'package:prompt_manager/features/prompts/presentation/screens/prompt_edit_screen.dart';

void main() {
  testWidgets('fills fields with existing prompt values', (tester) async {
    await tester.pumpWidget(_editTestApp(prompt: _prompt()));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(TextField, 'Baslik'), findsOneWidget);
    expect(find.text('Prompt title'), findsOneWidget);
    expect(find.text('Write about [TOPIC].'), findsOneWidget);
    expect(find.text('Description'), findsOneWidget);
    expect(find.text('Notes'), findsOneWidget);
    expect(find.text('Writing'), findsOneWidget);
    expect(find.text('launch, test'), findsOneWidget);
    expect(find.text('Ham'), findsOneWidget);
  });

  testWidgets('shows validation when promptText is empty', (tester) async {
    await tester.pumpWidget(_editTestApp(prompt: _prompt()));
    await tester.pumpAndSettle();

    await tester.enterText(find.widgetWithText(TextField, 'Prompt metni'), ' ');
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Kaydet'),
      500,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byType(FilledButton));
    await tester.pump();

    expect(find.text('Prompt metni bos olamaz.'), findsOneWidget);
  });

  testWidgets('save button shows loading state while update is pending', (
    tester,
  ) async {
    final repository = _FakePromptRepository(
      updateCompleter: Completer<void>(),
    );

    await tester.pumpWidget(
      _editTestApp(prompt: _prompt(), repository: repository),
    );
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('Kaydet'),
      500,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byType(FilledButton));
    await tester.pump();

    expect(find.text('Kaydediliyor'), findsOneWidget);

    repository.updateCompleter?.complete();
    await tester.pumpAndSettle();
  });

  testWidgets('status dropdown can select archived', (tester) async {
    final repository = _FakePromptRepository();

    await tester.pumpWidget(
      _editTestApp(prompt: _prompt(), repository: repository),
    );
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('Ham'),
      500,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ham'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Arsiv').last);
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('Kaydet'),
      500,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    expect(repository.updatedPrompt?.status, PromptStatus.archived);
  });

  testWidgets('successful save returns to detail route', (tester) async {
    final repository = _FakePromptRepository();

    await tester.pumpWidget(
      _editRouterTestApp(prompt: _prompt(), repository: repository),
    );
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('Kaydet'),
      500,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    expect(find.text('Detail prompt-1'), findsOneWidget);
    expect(repository.updatedPrompt, isNotNull);
  });
}

Widget _editTestApp({
  required PromptCard prompt,
  _FakePromptRepository? repository,
}) {
  return _editRouterTestApp(
    prompt: prompt,
    repository: repository ?? _FakePromptRepository(),
  );
}

Widget _editRouterTestApp({
  required PromptCard prompt,
  required _FakePromptRepository repository,
}) {
  final router = GoRouter(
    initialLocation: RoutePaths.promptEditLocation('prompt-1'),
    routes: [
      GoRoute(
        path: RoutePaths.promptEdit,
        builder: (context, state) =>
            PromptEditScreen(promptId: state.pathParameters['promptId'] ?? ''),
      ),
      GoRoute(
        path: RoutePaths.promptDetail,
        builder: (context, state) {
          return Scaffold(
            body: Text('Detail ${state.pathParameters['promptId']}'),
          );
        },
      ),
    ],
  );

  return ProviderScope(
    overrides: [
      promptDetailProvider.overrideWith((ref, promptId) {
        return Future<PromptCard?>.value(prompt);
      }),
      promptEditControllerProvider.overrideWith((ref) {
        return PromptEditController(
          authRepository: _FakeAuthRepository(
            currentUserValue: const AppUser(id: 'user-1', email: null),
          ),
          promptRepository: repository,
          parser: const PromptVariableParser(),
          now: () => DateTime(2026, 5, 30, 13),
        );
      }),
    ],
    child: MaterialApp.router(routerConfig: router),
  );
}

PromptCard _prompt() {
  return PromptCard(
    id: 'prompt-1',
    ownerId: 'user-1',
    title: 'Prompt title',
    promptText: 'Write about [TOPIC].',
    description: 'Description',
    notes: 'Notes',
    category: 'Writing',
    tags: const <String>['launch', 'test'],
    status: PromptStatus.raw,
    variables: const <String>['TOPIC'],
    createdAt: DateTime(2026, 5, 30),
    updatedAt: DateTime(2026, 5, 30, 12),
  );
}

class _FakeAuthRepository implements AuthRepository {
  _FakeAuthRepository({this.currentUserValue});

  final AppUser? currentUserValue;

  @override
  AppUser? get currentUser => currentUserValue;

  @override
  Stream<AppUser?> authStateChanges() =>
      Stream<AppUser?>.value(currentUserValue);

  @override
  Future<AppUser> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return AppUser(id: 'user-1', email: email);
  }

  @override
  Future<AppUser> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return AppUser(id: 'user-1', email: email);
  }

  @override
  Future<void> signOut() async {}
}

class _FakePromptRepository implements PromptRepository {
  _FakePromptRepository({this.updateCompleter});

  final Completer<void>? updateCompleter;
  PromptCard? updatedPrompt;

  @override
  Future<void> createPrompt(PromptCard prompt) async {}

  @override
  Future<PromptCard?> getPromptById({
    required String userId,
    required String promptId,
  }) async {
    return null;
  }

  @override
  Future<void> updatePrompt(PromptCard prompt) async {
    updatedPrompt = prompt;
    await updateCompleter?.future;
  }

  @override
  Stream<List<PromptCard>> watchPrompts({required String userId}) {
    return const Stream<List<PromptCard>>.empty();
  }
}
