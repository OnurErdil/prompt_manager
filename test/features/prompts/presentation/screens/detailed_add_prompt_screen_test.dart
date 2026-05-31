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
import 'package:prompt_manager/features/prompts/presentation/controllers/detailed_add_prompt_controller.dart';
import 'package:prompt_manager/features/prompts/presentation/providers/prompt_providers.dart';
import 'package:prompt_manager/features/prompts/presentation/screens/detailed_add_prompt_screen.dart';

void main() {
  testWidgets('shows validation when promptText is empty', (tester) async {
    await _useTallSurface(tester);

    await tester.pumpWidget(
      _detailedAddTestApp(repository: _FakePromptRepository()),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.widgetWithText(TextField, 'Prompt metni'), ' ');
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Kaydet'),
      500,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.drag(find.byType(Scrollable).first, const Offset(0, -220));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(FilledButton));
    await tester.pump();

    expect(find.text('Prompt metni bos olamaz.'), findsOneWidget);
  });

  testWidgets('save button shows loading state while create is pending', (
    tester,
  ) async {
    await _useTallSurface(tester);

    final repository = _FakePromptRepository(
      createCompleter: Completer<void>(),
    );

    await tester.pumpWidget(_detailedAddTestApp(repository: repository));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextField, 'Prompt metni'),
      'Write about [TOPIC].',
    );
    await tester.scrollUntilVisible(
      find.text('Kaydet'),
      500,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.drag(find.byType(Scrollable).first, const Offset(0, -220));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(FilledButton));
    await tester.pump();

    expect(find.text('Kaydediliyor'), findsOneWidget);

    repository.createCompleter?.complete();
    await tester.pumpAndSettle();
  });

  testWidgets('creates prompt with detailed fields and returns to library', (
    tester,
  ) async {
    await _useTallSurface(tester);

    final repository = _FakePromptRepository();

    await tester.pumpWidget(_detailedAddTestApp(repository: repository));
    await tester.pumpAndSettle();

    await tester.enterText(find.widgetWithText(TextField, 'Baslik'), ' Title ');
    await tester.enterText(
      find.widgetWithText(TextField, 'Prompt metni'),
      ' Write about [TOPIC] for [AUDIENCE]. ',
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Aciklama'),
      ' Description ',
    );
    await tester.enterText(find.widgetWithText(TextField, 'Notlar'), ' Notes ');
    await tester.enterText(
      find.widgetWithText(TextField, 'Kategori'),
      ' Marketing ',
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Etiketler'),
      ' launch, , ai ',
    );

    await tester.scrollUntilVisible(
      find.text('Ham'),
      500,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ham'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Kullanima Hazir').last);
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('Kaydet'),
      500,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.drag(find.byType(Scrollable).first, const Offset(0, -220));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    final prompt = repository.createdPrompt;
    expect(find.text('Library'), findsOneWidget);
    expect(prompt, isNotNull);
    expect(prompt?.id, 'prompt-1');
    expect(prompt?.ownerId, 'user-1');
    expect(prompt?.title, 'Title');
    expect(prompt?.promptText, 'Write about [TOPIC] for [AUDIENCE].');
    expect(prompt?.description, 'Description');
    expect(prompt?.notes, 'Notes');
    expect(prompt?.category, 'Marketing');
    expect(prompt?.tags, <String>['launch', 'ai']);
    expect(prompt?.status, PromptStatus.ready);
    expect(prompt?.variables, <String>['TOPIC', 'AUDIENCE']);
    expect(prompt?.createdAt, DateTime(2026, 5, 31, 11));
    expect(prompt?.updatedAt, DateTime(2026, 5, 31, 11));
    expect(prompt?.schemaVersion, 1);
  });
}

Future<void> _useTallSurface(WidgetTester tester) async {
  await tester.binding.setSurfaceSize(const Size(800, 1000));
  addTearDown(() => tester.binding.setSurfaceSize(null));
}

Widget _detailedAddTestApp({required _FakePromptRepository repository}) {
  final router = GoRouter(
    initialLocation: RoutePaths.detailedAddPrompt,
    routes: [
      GoRoute(
        path: RoutePaths.detailedAddPrompt,
        builder: (context, state) => const DetailedAddPromptScreen(),
      ),
      GoRoute(
        path: RoutePaths.library,
        builder: (context, state) => const Scaffold(body: Text('Library')),
      ),
    ],
  );

  return ProviderScope(
    overrides: [
      detailedAddPromptControllerProvider.overrideWith((ref) {
        return DetailedAddPromptController(
          authRepository: _FakeAuthRepository(
            currentUserValue: const AppUser(id: 'user-1', email: null),
          ),
          promptRepository: repository,
          parser: const PromptVariableParser(),
          now: () => DateTime(2026, 5, 31, 11),
          idGenerator: (_) => 'prompt-1',
        );
      }),
    ],
    child: MaterialApp.router(routerConfig: router),
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
  _FakePromptRepository({this.createCompleter});

  final Completer<void>? createCompleter;
  PromptCard? createdPrompt;

  @override
  Future<void> createPrompt(PromptCard prompt) async {
    createdPrompt = prompt;
    await createCompleter?.future;
  }

  @override
  Future<PromptCard?> getPromptById({
    required String userId,
    required String promptId,
  }) async {
    return null;
  }

  @override
  Future<void> updatePrompt(PromptCard prompt) async {}

  @override
  Stream<List<PromptCard>> watchPrompts({required String userId}) {
    return const Stream<List<PromptCard>>.empty();
  }
}
