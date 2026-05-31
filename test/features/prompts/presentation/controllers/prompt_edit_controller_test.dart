import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prompt_manager/features/auth/domain/entities/app_user.dart';
import 'package:prompt_manager/features/auth/domain/repositories/auth_repository.dart';
import 'package:prompt_manager/features/prompts/domain/entities/prompt_card.dart';
import 'package:prompt_manager/features/prompts/domain/enums/prompt_status.dart';
import 'package:prompt_manager/features/prompts/domain/repositories/prompt_repository.dart';
import 'package:prompt_manager/features/prompts/domain/services/prompt_variable_parser.dart';
import 'package:prompt_manager/features/prompts/presentation/controllers/prompt_edit_controller.dart';

void main() {
  group('PromptEditController', () {
    final createdAt = DateTime(2026, 5, 30, 10);
    final originalUpdatedAt = DateTime(2026, 5, 30, 11);
    final updatedAt = DateTime(2026, 5, 30, 12);

    test('does not call update when promptText is empty', () async {
      final repository = _FakePromptRepository();
      final controller = _controller(repository: repository, now: updatedAt);

      await controller.updatePrompt(
        originalPrompt: _prompt(
          createdAt: createdAt,
          updatedAt: originalUpdatedAt,
        ),
        title: 'Title',
        promptText: '   ',
        description: '',
        notes: '',
        category: '',
        tagsInput: '',
        status: PromptStatus.ready,
      );

      expect(repository.updatedPrompt, isNull);
      expect(controller.state.hasError, isTrue);
    });

    test('does not call update when user is missing', () async {
      final repository = _FakePromptRepository();
      final controller = _controller(
        repository: repository,
        currentUser: null,
        now: updatedAt,
      );

      await controller.updatePrompt(
        originalPrompt: _prompt(
          createdAt: createdAt,
          updatedAt: originalUpdatedAt,
        ),
        title: 'Title',
        promptText: 'Prompt text',
        description: '',
        notes: '',
        category: '',
        tagsInput: '',
        status: PromptStatus.ready,
      );

      expect(repository.updatedPrompt, isNull);
      expect(controller.state.hasError, isTrue);
    });

    test('updates prompt and preserves immutable fields', () async {
      final repository = _FakePromptRepository();
      final original = _prompt(
        createdAt: createdAt,
        updatedAt: originalUpdatedAt,
      );
      final controller = _controller(repository: repository, now: updatedAt);

      await controller.updatePrompt(
        originalPrompt: original,
        title: '  Updated title  ',
        promptText: '  Write about [TOPIC] for [AUDIENCE].  ',
        description: '  Updated description  ',
        notes: '  Updated notes  ',
        category: '  Writing  ',
        tagsInput: ' launch, , ai , productivity ',
        status: PromptStatus.archived,
      );

      final prompt = repository.updatedPrompt;
      expect(prompt, isNotNull);
      expect(prompt?.id, original.id);
      expect(prompt?.ownerId, original.ownerId);
      expect(prompt?.createdAt, original.createdAt);
      expect(prompt?.schemaVersion, original.schemaVersion);
      expect(prompt?.title, 'Updated title');
      expect(prompt?.promptText, 'Write about [TOPIC] for [AUDIENCE].');
      expect(prompt?.description, 'Updated description');
      expect(prompt?.notes, 'Updated notes');
      expect(prompt?.category, 'Writing');
      expect(prompt?.tags, <String>['launch', 'ai', 'productivity']);
      expect(prompt?.variables, <String>['TOPIC', 'AUDIENCE']);
      expect(prompt?.status, PromptStatus.archived);
      expect(prompt?.updatedAt, updatedAt);
      expect(controller.state, const AsyncValue<void>.data(null));
    });
  });
}

PromptEditController _controller({
  required _FakePromptRepository repository,
  AppUser? currentUser = const AppUser(id: 'user-1', email: null),
  required DateTime now,
}) {
  return PromptEditController(
    authRepository: _FakeAuthRepository(currentUserValue: currentUser),
    promptRepository: repository,
    parser: const PromptVariableParser(),
    now: () => now,
  );
}

PromptCard _prompt({required DateTime createdAt, required DateTime updatedAt}) {
  return PromptCard(
    id: 'prompt-1',
    ownerId: 'user-1',
    title: 'Original title',
    promptText: 'Original prompt.',
    description: 'Original description',
    notes: 'Original notes',
    category: 'Original category',
    tags: const <String>['original'],
    status: PromptStatus.raw,
    variables: const <String>[],
    createdAt: createdAt,
    updatedAt: updatedAt,
    schemaVersion: 1,
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
  }

  @override
  Stream<List<PromptCard>> watchPrompts({required String userId}) {
    return const Stream<List<PromptCard>>.empty();
  }
}
