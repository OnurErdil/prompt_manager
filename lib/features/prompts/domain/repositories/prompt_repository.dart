import '../entities/prompt_card.dart';

abstract interface class PromptRepository {
  Future<void> createPrompt(PromptCard prompt);

  Stream<List<PromptCard>> watchPrompts({required String userId});

  Future<PromptCard?> getPromptById({
    required String userId,
    required String promptId,
  });

  Future<void> updatePrompt(PromptCard prompt);
}
