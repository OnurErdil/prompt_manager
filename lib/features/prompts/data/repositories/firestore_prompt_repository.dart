import '../../domain/entities/prompt_card.dart';
import '../../domain/repositories/prompt_repository.dart';
import '../mappers/prompt_card_mapper.dart';
import '../services/prompt_firestore_service.dart';

class FirestorePromptRepository implements PromptRepository {
  const FirestorePromptRepository({required PromptFirestoreService service})
    : _service = service;

  final PromptFirestoreService _service;

  @override
  Future<void> createPrompt(PromptCard prompt) {
    return _service.createPrompt(prompt.toDto());
  }

  @override
  Stream<List<PromptCard>> watchPrompts({required String userId}) {
    return _service
        .watchPrompts(userId: userId)
        .map(
          (dtos) => dtos.map((dto) => dto.toDomain()).toList(growable: false),
        );
  }

  @override
  Future<PromptCard?> getPromptById({
    required String userId,
    required String promptId,
  }) async {
    final dto = await _service.getPromptById(
      userId: userId,
      promptId: promptId,
    );

    return dto?.toDomain();
  }

  @override
  Future<void> updatePrompt(PromptCard prompt) {
    return _service.updatePrompt(prompt.toDto());
  }
}
