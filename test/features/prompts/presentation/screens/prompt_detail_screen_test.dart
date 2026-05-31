import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:prompt_manager/app/router/route_names.dart';
import 'package:prompt_manager/features/prompts/domain/entities/prompt_card.dart';
import 'package:prompt_manager/features/prompts/domain/enums/prompt_status.dart';
import 'package:prompt_manager/features/prompts/presentation/providers/prompt_providers.dart';
import 'package:prompt_manager/features/prompts/presentation/screens/prompt_detail_screen.dart';

void main() {
  testWidgets('renders prompt title and promptText in data state', (
    tester,
  ) async {
    await tester.pumpWidget(
      _detailTestApp(
        prompt: _prompt(
          title: 'Launch prompt',
          promptText: 'Write a launch plan for [PRODUCT].',
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Launch prompt'), findsOneWidget);
    expect(find.text('Write a launch plan for [PRODUCT].'), findsOneWidget);
    expect(find.text('Normal Kopyala'), findsOneWidget);
  });

  testWidgets('renders fallback title when title is empty', (tester) async {
    await tester.pumpWidget(
      _detailTestApp(
        prompt: _prompt(title: '', promptText: 'Fallback prompt title text.'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Fallback prompt title text.'), findsWidgets);
  });

  testWidgets('renders not found state', (tester) async {
    await tester.pumpWidget(_detailTestApp(prompt: null));
    await tester.pumpAndSettle();

    expect(find.text('Prompt bulunamadi'), findsOneWidget);
  });

  testWidgets('renders error state', (tester) async {
    await tester.pumpWidget(_detailTestApp(error: StateError('boom')));
    await tester.pumpAndSettle();

    expect(find.text('Prompt yuklenemedi'), findsOneWidget);
  });

  testWidgets('copy button writes promptText and shows snackbar', (
    tester,
  ) async {
    final binding = TestWidgetsFlutterBinding.ensureInitialized();
    final clipboardCalls = <MethodCall>[];
    binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        clipboardCalls.add(call);
        return null;
      },
    );
    addTearDown(
      () => binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      ),
    );

    await tester.pumpWidget(
      _detailTestApp(prompt: _prompt(promptText: 'Copy this prompt.')),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Normal Kopyala'));
    await tester.pumpAndSettle();

    expect(find.text('Prompt kopyalandi.'), findsOneWidget);
    expect(
      clipboardCalls.any(
        (call) =>
            call.method == 'Clipboard.setData' &&
            call.arguments is Map &&
            (call.arguments as Map)['text'] == 'Copy this prompt.',
      ),
      isTrue,
    );
  });

  testWidgets('edit button opens edit route', (tester) async {
    final router = GoRouter(
      initialLocation: RoutePaths.promptDetailLocation('prompt-1'),
      routes: [
        GoRoute(
          path: RoutePaths.promptDetail,
          builder: (context, state) {
            return PromptDetailScreen(
              promptId: state.pathParameters['promptId'] ?? '',
            );
          },
        ),
        GoRoute(
          path: RoutePaths.promptEdit,
          builder: (context, state) {
            return Scaffold(
              body: Text('Edit ${state.pathParameters['promptId']}'),
            );
          },
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          promptDetailProvider.overrideWith((ref, promptId) {
            return Future<PromptCard?>.value(_prompt());
          }),
        ],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Duzenle'));
    await tester.pumpAndSettle();

    expect(find.text('Edit prompt-1'), findsOneWidget);
  });
}

Widget _detailTestApp({PromptCard? prompt, Object? error}) {
  return ProviderScope(
    overrides: [
      promptDetailProvider.overrideWith((ref, promptId) {
        if (error != null) {
          throw error;
        }

        return Future<PromptCard?>.value(prompt);
      }),
    ],
    child: const MaterialApp(home: PromptDetailScreen(promptId: 'prompt-1')),
  );
}

PromptCard _prompt({
  String title = 'Prompt title',
  String promptText = 'Write about [TOPIC].',
}) {
  return PromptCard(
    id: 'prompt-1',
    ownerId: 'user-1',
    title: title,
    promptText: promptText,
    description: 'Description',
    notes: 'Notes',
    category: 'Writing',
    tags: const <String>['launch'],
    status: PromptStatus.raw,
    variables: const <String>['TOPIC'],
    createdAt: DateTime(2026, 5, 30),
    updatedAt: DateTime(2026, 5, 30, 12),
  );
}
