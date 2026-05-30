import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prompt_manager/features/auth/domain/entities/app_user.dart';
import 'package:prompt_manager/features/auth/domain/repositories/auth_repository.dart';
import 'package:prompt_manager/features/prompts/domain/entities/prompt_card.dart';
import 'package:prompt_manager/features/prompts/domain/enums/prompt_status.dart';
import 'package:prompt_manager/features/prompts/domain/repositories/prompt_repository.dart';
import 'package:prompt_manager/features/prompts/domain/services/prompt_variable_parser.dart';
import 'package:prompt_manager/features/prompts/presentation/controllers/quick_add_prompt_controller.dart';

void main() {
  group('QuickAddPromptController', () {
    final fixedNow = DateTime(2026, 5, 30, 12, 15);

    test('does not call create when promptText is empty', () async {
      final repository = _FakePromptRepository();
      final controller = QuickAddPromptController(
        authRepository: _FakeAuthRepository(
          currentUserValue: const AppUser(id: 'user-1', email: null),
        ),
        promptRepository: repository,
        parser: const PromptVariableParser(),
        now: () => fixedNow,
        idGenerator: (_) => 'prompt-1',
      );

      await controller.createPrompt(promptText: '   ');

      expect(repository.createdPrompt, isNull);
      expect(controller.state.hasError, isTrue);
    });

    test('creates prompt with M4 defaults', () async {
      final repository = _FakePromptRepository();
      final controller = QuickAddPromptController(
        authRepository: _FakeAuthRepository(
          currentUserValue: const AppUser(id: 'user-1', email: null),
        ),
        promptRepository: repository,
        parser: const PromptVariableParser(),
        now: () => fixedNow,
        idGenerator: (_) => 'prompt-1',
      );

      await controller.createPrompt(
        promptText: '  Write about [TOPIC] for [AUDIENCE].  ',
      );

      final prompt = repository.createdPrompt;
      expect(prompt, isNotNull);
      expect(prompt?.id, 'prompt-1');
      expect(prompt?.ownerId, 'user-1');
      expect(prompt?.title, '');
      expect(prompt?.promptText, 'Write about [TOPIC] for [AUDIENCE].');
      expect(prompt?.description, '');
      expect(prompt?.notes, '');
      expect(prompt?.category, '');
      expect(prompt?.tags, isEmpty);
      expect(prompt?.status, PromptStatus.raw);
      expect(prompt?.variables, <String>['TOPIC', 'AUDIENCE']);
      expect(prompt?.createdAt, fixedNow);
      expect(prompt?.updatedAt, fixedNow);
      expect(prompt?.schemaVersion, 1);
      expect(controller.state, const AsyncValue<void>.data(null));
    });
  });
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
  PromptCard? createdPrompt;

  @override
  Future<void> createPrompt(PromptCard prompt) async {
    createdPrompt = prompt;
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
