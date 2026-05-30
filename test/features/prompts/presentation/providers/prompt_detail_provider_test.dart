import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prompt_manager/features/auth/domain/entities/app_user.dart';
import 'package:prompt_manager/features/auth/domain/repositories/auth_repository.dart';
import 'package:prompt_manager/features/auth/presentation/providers/auth_providers.dart';
import 'package:prompt_manager/features/prompts/domain/entities/prompt_card.dart';
import 'package:prompt_manager/features/prompts/domain/repositories/prompt_repository.dart';
import 'package:prompt_manager/features/prompts/presentation/providers/prompt_providers.dart';

void main() {
  group('promptDetailProvider', () {
    test('does not call repository when user is missing', () async {
      final repository = _FakePromptRepository();
      final container = ProviderContainer(
        overrides: [
          authRepositoryProvider.overrideWith(
            (ref) => _FakeAuthRepository(currentUserValue: null),
          ),
          promptRepositoryProvider.overrideWith((ref) => repository),
        ],
      );
      addTearDown(container.dispose);

      final prompt = await container.read(
        promptDetailProvider('prompt-1').future,
      );

      expect(prompt, isNull);
      expect(repository.requestedUserId, isNull);
      expect(repository.requestedPromptId, isNull);
    });

    test('calls repository with current user id when user exists', () async {
      final expectedPrompt = _prompt(id: 'prompt-1', ownerId: 'user-1');
      final repository = _FakePromptRepository(foundPrompt: expectedPrompt);
      final container = ProviderContainer(
        overrides: [
          authRepositoryProvider.overrideWith(
            (ref) => _FakeAuthRepository(
              currentUserValue: const AppUser(id: 'user-1', email: null),
            ),
          ),
          promptRepositoryProvider.overrideWith((ref) => repository),
        ],
      );
      addTearDown(container.dispose);

      final prompt = await container.read(
        promptDetailProvider('prompt-1').future,
      );

      expect(prompt, expectedPrompt);
      expect(repository.requestedUserId, 'user-1');
      expect(repository.requestedPromptId, 'prompt-1');
    });
  });
}

PromptCard _prompt({required String id, required String ownerId}) {
  return PromptCard(
    id: id,
    ownerId: ownerId,
    promptText: 'Write about [TOPIC].',
    createdAt: DateTime(2026, 5, 30),
    updatedAt: DateTime(2026, 5, 30, 12),
  );
}

class _FakeAuthRepository implements AuthRepository {
  _FakeAuthRepository({required this.currentUserValue});

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
  _FakePromptRepository({this.foundPrompt});

  final PromptCard? foundPrompt;
  String? requestedUserId;
  String? requestedPromptId;

  @override
  Future<void> createPrompt(PromptCard prompt) async {}

  @override
  Future<PromptCard?> getPromptById({
    required String userId,
    required String promptId,
  }) async {
    requestedUserId = userId;
    requestedPromptId = promptId;
    return foundPrompt;
  }

  @override
  Future<void> updatePrompt(PromptCard prompt) async {}

  @override
  Stream<List<PromptCard>> watchPrompts({required String userId}) {
    return const Stream<List<PromptCard>>.empty();
  }
}
