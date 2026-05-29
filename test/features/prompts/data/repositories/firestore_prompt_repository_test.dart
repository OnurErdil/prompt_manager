import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:prompt_manager/features/prompts/data/dtos/prompt_card_dto.dart';
import 'package:prompt_manager/features/prompts/data/repositories/firestore_prompt_repository.dart';
import 'package:prompt_manager/features/prompts/data/services/prompt_firestore_service.dart';
import 'package:prompt_manager/features/prompts/domain/entities/prompt_card.dart';
import 'package:prompt_manager/features/prompts/domain/enums/prompt_status.dart';

void main() {
  group('FirestorePromptRepository', () {
    final createdAt = DateTime(2026, 5, 29, 10, 30);
    final updatedAt = DateTime(2026, 5, 29, 11, 45);

    PromptCard prompt() {
      return PromptCard(
        id: 'prompt-1',
        ownerId: 'user-1',
        title: 'Prompt title',
        promptText: 'Write about [TOPIC].',
        description: 'Short description',
        notes: 'Internal notes',
        category: 'Writing',
        tags: <String>['draft', 'blog'],
        status: PromptStatus.ready,
        variables: <String>['TOPIC'],
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
    }

    PromptCardDto dto({String id = 'prompt-1'}) {
      return PromptCardDto(
        id: id,
        ownerId: 'user-1',
        title: 'Prompt title',
        promptText: 'Write about [TOPIC].',
        description: 'Short description',
        notes: 'Internal notes',
        category: 'Writing',
        tags: <String>['draft', 'blog'],
        status: 'ready',
        variables: <String>['TOPIC'],
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
    }

    test('createPrompt maps domain prompt to dto and calls service', () async {
      final service = _FakePromptFirestoreService();
      final repository = FirestorePromptRepository(service: service);

      await repository.createPrompt(prompt());

      expect(service.createdDto?.id, 'prompt-1');
      expect(service.createdDto?.ownerId, 'user-1');
      expect(service.createdDto?.status, 'ready');
      expect(service.createdDto?.createdAt, createdAt);
      expect(service.createdDto?.updatedAt, updatedAt);
    });

    test('watchPrompts maps dto stream to domain stream', () async {
      final service = _FakePromptFirestoreService(
        watchStream: Stream<List<PromptCardDto>>.value(<PromptCardDto>[
          dto(),
          dto(id: 'prompt-2'),
        ]),
      );
      final repository = FirestorePromptRepository(service: service);

      final prompts = await repository.watchPrompts(userId: 'user-1').first;

      expect(service.watchedUserId, 'user-1');
      expect(prompts, hasLength(2));
      expect(prompts.first.id, 'prompt-1');
      expect(prompts.first.status, PromptStatus.ready);
      expect(prompts.last.id, 'prompt-2');
    });

    test('getPromptById returns null when service returns null', () async {
      final service = _FakePromptFirestoreService();
      final repository = FirestorePromptRepository(service: service);

      final prompt = await repository.getPromptById(
        userId: 'user-1',
        promptId: 'missing',
      );

      expect(prompt, isNull);
      expect(service.requestedUserId, 'user-1');
      expect(service.requestedPromptId, 'missing');
    });

    test('getPromptById maps dto to domain when found', () async {
      final service = _FakePromptFirestoreService(foundDto: dto());
      final repository = FirestorePromptRepository(service: service);

      final prompt = await repository.getPromptById(
        userId: 'user-1',
        promptId: 'prompt-1',
      );

      expect(prompt?.id, 'prompt-1');
      expect(prompt?.status, PromptStatus.ready);
      expect(prompt?.createdAt, createdAt);
      expect(prompt?.updatedAt, updatedAt);
    });

    test('updatePrompt maps domain prompt to dto and calls service', () async {
      final service = _FakePromptFirestoreService();
      final repository = FirestorePromptRepository(service: service);

      await repository.updatePrompt(prompt());

      expect(service.updatedDto?.id, 'prompt-1');
      expect(service.updatedDto?.ownerId, 'user-1');
      expect(service.updatedDto?.status, 'ready');
    });
  });
}

class _FakePromptFirestoreService implements PromptFirestoreService {
  _FakePromptFirestoreService({this.watchStream, this.foundDto});

  final Stream<List<PromptCardDto>>? watchStream;
  final PromptCardDto? foundDto;

  PromptCardDto? createdDto;
  PromptCardDto? updatedDto;
  String? watchedUserId;
  String? requestedUserId;
  String? requestedPromptId;

  @override
  Future<void> createPrompt(PromptCardDto dto) async {
    createdDto = dto;
  }

  @override
  Stream<List<PromptCardDto>> watchPrompts({required String userId}) {
    watchedUserId = userId;
    return watchStream ?? const Stream<List<PromptCardDto>>.empty();
  }

  @override
  Future<PromptCardDto?> getPromptById({
    required String userId,
    required String promptId,
  }) async {
    requestedUserId = userId;
    requestedPromptId = promptId;
    return foundDto;
  }

  @override
  Future<void> updatePrompt(PromptCardDto dto) async {
    updatedDto = dto;
  }
}
