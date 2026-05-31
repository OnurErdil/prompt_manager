import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prompt_manager/features/auth/domain/entities/app_user.dart';
import 'package:prompt_manager/features/auth/domain/repositories/auth_repository.dart';
import 'package:prompt_manager/features/prompts/domain/entities/prompt_card.dart';
import 'package:prompt_manager/features/prompts/domain/enums/prompt_status.dart';
import 'package:prompt_manager/features/prompts/domain/repositories/prompt_repository.dart';
import 'package:prompt_manager/features/prompts/domain/services/prompt_variable_parser.dart';
import 'package:prompt_manager/features/prompts/presentation/controllers/detailed_add_prompt_controller.dart';

void main() {
  group('DetailedAddPromptController', () {
    final fixedNow = DateTime(2026, 5, 31, 10, 30);

    test('does not call create when promptText is empty', () async {
      final repository = _FakePromptRepository();
      final controller = _controller(repository: repository, now: fixedNow);

      await controller.createPrompt(
        title: 'Title',
        promptText: '   ',
        description: '',
        notes: '',
        category: '',
        tagsInput: '',
        status: PromptStatus.ready,
      );

      expect(repository.createdPrompt, isNull);
      expect(controller.state.hasError, isTrue);
    });

    test('does not call create when user is missing', () async {
      final repository = _FakePromptRepository();
      final controller = _controller(
        repository: repository,
        currentUser: null,
        now: fixedNow,
      );

      await controller.createPrompt(
        title: 'Title',
        promptText: 'Prompt text',
        description: '',
        notes: '',
        category: '',
        tagsInput: '',
        status: PromptStatus.ready,
      );

      expect(repository.createdPrompt, isNull);
      expect(controller.state.hasError, isTrue);
    });

    test('creates detailed prompt with normalized fields', () async {
      final repository = _FakePromptRepository();
      final controller = _controller(repository: repository, now: fixedNow);

      await controller.createPrompt(
        title: '  Launch title  ',
        promptText: '  Write about [TOPIC] for [AUDIENCE].  ',
        description: '  Description  ',
        notes: '  Notes  ',
        category: '  Marketing  ',
        tagsInput: ' launch, , ai , productivity ',
        status: PromptStatus.ready,
      );

      final prompt = repository.createdPrompt;
      expect(prompt, isNotNull);
      expect(prompt?.id, 'prompt-1');
      expect(prompt?.ownerId, 'user-1');
      expect(prompt?.title, 'Launch title');
      expect(prompt?.promptText, 'Write about [TOPIC] for [AUDIENCE].');
      expect(prompt?.description, 'Description');
      expect(prompt?.notes, 'Notes');
      expect(prompt?.category, 'Marketing');
      expect(prompt?.tags, <String>['launch', 'ai', 'productivity']);
      expect(prompt?.status, PromptStatus.ready);
      expect(prompt?.variables, <String>['TOPIC', 'AUDIENCE']);
      expect(prompt?.createdAt, fixedNow);
      expect(prompt?.updatedAt, fixedNow);
      expect(prompt?.schemaVersion, 1);
      expect(controller.state, const AsyncValue<void>.data(null));
    });
  });
}

DetailedAddPromptController _controller({
  required _FakePromptRepository repository,
  AppUser? currentUser = const AppUser(id: 'user-1', email: null),
  required DateTime now,
}) {
  return DetailedAddPromptController(
    authRepository: _FakeAuthRepository(currentUserValue: currentUser),
    promptRepository: repository,
    parser: const PromptVariableParser(),
    now: () => now,
    idGenerator: (_) => 'prompt-1',
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
