import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:prompt_manager/app/router/route_names.dart';
import 'package:prompt_manager/features/auth/domain/entities/app_user.dart';
import 'package:prompt_manager/features/auth/domain/repositories/auth_repository.dart';
import 'package:prompt_manager/features/auth/presentation/providers/auth_providers.dart';
import 'package:prompt_manager/features/prompts/domain/entities/prompt_card.dart';
import 'package:prompt_manager/features/prompts/domain/enums/prompt_status.dart';
import 'package:prompt_manager/features/prompts/domain/repositories/prompt_repository.dart';
import 'package:prompt_manager/features/prompts/presentation/providers/prompt_providers.dart';
import 'package:prompt_manager/features/prompts/presentation/screens/prompt_library_screen.dart';

void main() {
  testWidgets('renders empty state when user has no prompts', (tester) async {
    await tester.pumpWidget(_libraryTestApp(prompts: const <PromptCard>[]));
    await tester.pumpAndSettle();

    expect(find.text('Ilk promptunu yakala'), findsOneWidget);
    expect(find.text('Ilk promptunu ekle'), findsOneWidget);
  });

  testWidgets('renders prompt list when user has prompts', (tester) async {
    await tester.pumpWidget(
      _libraryTestApp(
        prompts: <PromptCard>[
          PromptCard(
            id: 'prompt-1',
            ownerId: 'user-1',
            title: '',
            promptText: 'Write a launch plan for [PRODUCT].',
            description: '',
            notes: '',
            category: '',
            createdAt: DateTime(2026, 5, 30),
            updatedAt: DateTime(2026, 5, 30, 12),
          ),
        ],
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Write a launch plan for [PRODUCT].'), findsWidgets);
    expect(find.textContaining('Durum: raw'), findsOneWidget);
  });

  testWidgets('hides archived prompts by default', (tester) async {
    await tester.pumpWidget(
      _libraryTestApp(
        prompts: <PromptCard>[
          _prompt(id: 'prompt-1', title: 'Active prompt'),
          _prompt(
            id: 'prompt-2',
            title: 'Archived prompt',
            status: PromptStatus.archived,
          ),
        ],
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Active prompt'), findsOneWidget);
    expect(find.text('Archived prompt'), findsNothing);
  });

  testWidgets('shows archived prompts when archived status is selected', (
    tester,
  ) async {
    await tester.pumpWidget(
      _libraryTestApp(
        prompts: <PromptCard>[
          _prompt(id: 'prompt-1', title: 'Active prompt'),
          _prompt(
            id: 'prompt-2',
            title: 'Archived prompt',
            status: PromptStatus.archived,
          ),
        ],
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(ChoiceChip, 'archived'));
    await tester.pumpAndSettle();

    expect(find.text('Active prompt'), findsNothing);
    expect(find.text('Archived prompt'), findsOneWidget);
  });

  testWidgets('searches prompts and shows empty result state', (tester) async {
    await tester.pumpWidget(
      _libraryTestApp(
        prompts: <PromptCard>[_prompt(id: 'prompt-1', title: 'Launch prompt')],
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'missing value');
    await tester.pumpAndSettle();

    expect(find.text('Sonuc bulunamadi'), findsOneWidget);
    expect(find.text('Ilk promptunu yakala'), findsNothing);
  });

  testWidgets('clear filters returns to default active state', (tester) async {
    await tester.pumpWidget(
      _libraryTestApp(
        prompts: <PromptCard>[
          _prompt(id: 'prompt-1', title: 'Active prompt'),
          _prompt(
            id: 'prompt-2',
            title: 'Archived prompt',
            status: PromptStatus.archived,
          ),
        ],
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(ChoiceChip, 'archived'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Filtreleri temizle'));
    await tester.pumpAndSettle();

    expect(find.text('Active prompt'), findsOneWidget);
    expect(find.text('Archived prompt'), findsNothing);
  });

  testWidgets('opens detail route when list item is tapped', (tester) async {
    await tester.pumpWidget(
      _libraryRouterTestApp(
        prompts: <PromptCard>[
          PromptCard(
            id: 'prompt-1',
            ownerId: 'user-1',
            title: '',
            promptText: 'Open this prompt.',
            description: '',
            notes: '',
            category: '',
            createdAt: DateTime(2026, 5, 30),
            updatedAt: DateTime(2026, 5, 30, 12),
          ),
        ],
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Open this prompt.').first);
    await tester.pumpAndSettle();

    expect(find.text('Detail prompt-1'), findsOneWidget);
  });

  testWidgets('opens detailed add route from app bar action', (tester) async {
    await tester.pumpWidget(
      _libraryRouterTestApp(prompts: const <PromptCard>[]),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Detayli Ekle'));
    await tester.pumpAndSettle();

    expect(find.text('Detailed add route'), findsOneWidget);
  });

  testWidgets('opens quick add route from floating action button', (
    tester,
  ) async {
    await tester.pumpWidget(
      _libraryRouterTestApp(prompts: const <PromptCard>[]),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Hizli Ekle'));
    await tester.pumpAndSettle();

    expect(find.text('Quick add route'), findsOneWidget);
  });
}

Widget _libraryTestApp({required List<PromptCard> prompts}) {
  return ProviderScope(
    overrides: [
      authRepositoryProvider.overrideWith(
        (ref) => _FakeAuthRepository(
          currentUserValue: const AppUser(id: 'user-1', email: null),
        ),
      ),
      promptRepositoryProvider.overrideWith(
        (ref) => _FakePromptRepository(prompts: prompts),
      ),
    ],
    child: const MaterialApp(home: PromptLibraryScreen()),
  );
}

Widget _libraryRouterTestApp({required List<PromptCard> prompts}) {
  final router = GoRouter(
    initialLocation: RoutePaths.library,
    routes: [
      GoRoute(
        path: RoutePaths.library,
        builder: (context, state) => const PromptLibraryScreen(),
      ),
      GoRoute(
        path: RoutePaths.detailedAddPrompt,
        builder: (context, state) {
          return const Scaffold(body: Text('Detailed add route'));
        },
      ),
      GoRoute(
        path: RoutePaths.quickAddPrompt,
        builder: (context, state) {
          return const Scaffold(body: Text('Quick add route'));
        },
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
      authRepositoryProvider.overrideWith(
        (ref) => _FakeAuthRepository(
          currentUserValue: const AppUser(id: 'user-1', email: null),
        ),
      ),
      promptRepositoryProvider.overrideWith(
        (ref) => _FakePromptRepository(prompts: prompts),
      ),
    ],
    child: MaterialApp.router(routerConfig: router),
  );
}

PromptCard _prompt({
  required String id,
  required String title,
  PromptStatus status = PromptStatus.raw,
}) {
  return PromptCard(
    id: id,
    ownerId: 'user-1',
    title: title,
    promptText: '$title prompt text.',
    description: '',
    notes: '',
    category: '',
    status: status,
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
  _FakePromptRepository({required this.prompts});

  final List<PromptCard> prompts;

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
  Future<void> updatePrompt(PromptCard prompt) async {}

  @override
  Stream<List<PromptCard>> watchPrompts({required String userId}) {
    return Stream<List<PromptCard>>.value(prompts);
  }
}
