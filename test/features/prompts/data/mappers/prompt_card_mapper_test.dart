import 'package:flutter_test/flutter_test.dart';
import 'package:prompt_manager/features/prompts/data/dtos/prompt_card_dto.dart';
import 'package:prompt_manager/features/prompts/data/mappers/prompt_card_mapper.dart';
import 'package:prompt_manager/features/prompts/domain/entities/prompt_card.dart';
import 'package:prompt_manager/features/prompts/domain/enums/prompt_status.dart';

void main() {
  group('PromptCardMapper', () {
    final createdAt = DateTime(2026, 5, 29, 10, 30);
    final updatedAt = DateTime(2026, 5, 29, 11, 45);

    test('maps domain to dto', () {
      final card = PromptCard(
        id: 'prompt-1',
        ownerId: 'user-1',
        title: 'Prompt title',
        promptText: 'Write about [TOPIC].',
        description: 'Short description',
        notes: 'Internal notes',
        category: 'Writing',
        tags: <String>['draft', 'blog'],
        status: PromptStatus.needsEdit,
        variables: <String>['TOPIC'],
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

      final dto = card.toDto();

      expect(dto.id, card.id);
      expect(dto.ownerId, card.ownerId);
      expect(dto.title, card.title);
      expect(dto.promptText, card.promptText);
      expect(dto.description, card.description);
      expect(dto.notes, card.notes);
      expect(dto.category, card.category);
      expect(dto.tags, <String>['draft', 'blog']);
      expect(dto.status, 'needs_edit');
      expect(dto.variables, <String>['TOPIC']);
      expect(dto.createdAt, createdAt);
      expect(dto.updatedAt, updatedAt);
      expect(dto.schemaVersion, 1);
    });

    test('maps dto to domain', () {
      final dto = PromptCardDto(
        id: 'prompt-1',
        ownerId: 'user-1',
        title: 'Prompt title',
        promptText: 'Write about [TOPIC].',
        description: 'Short description',
        notes: 'Internal notes',
        category: 'Writing',
        tags: <String>['draft', 'blog'],
        status: 'archived',
        variables: <String>['TOPIC'],
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

      final card = dto.toDomain();

      expect(card.id, dto.id);
      expect(card.ownerId, dto.ownerId);
      expect(card.title, dto.title);
      expect(card.promptText, dto.promptText);
      expect(card.description, dto.description);
      expect(card.notes, dto.notes);
      expect(card.category, dto.category);
      expect(card.tags, <String>['draft', 'blog']);
      expect(card.status, PromptStatus.archived);
      expect(card.variables, <String>['TOPIC']);
      expect(card.createdAt, createdAt);
      expect(card.updatedAt, updatedAt);
      expect(card.schemaVersion, 1);
    });

    test('falls back to raw when dto status is invalid', () {
      final dto = PromptCardDto(
        id: 'prompt-1',
        ownerId: 'user-1',
        promptText: 'Write a summary.',
        status: 'invalid',
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

      expect(dto.toDomain().status, PromptStatus.raw);
    });
  });
}
