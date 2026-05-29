import 'package:flutter_test/flutter_test.dart';
import 'package:prompt_manager/features/prompts/data/dtos/prompt_card_dto.dart';

void main() {
  group('PromptCardDto', () {
    final createdAt = DateTime(2026, 5, 29, 10, 30);
    final updatedAt = DateTime(2026, 5, 29, 11, 45);

    Map<String, dynamic> fullMap() {
      return <String, dynamic>{
        'id': 'prompt-1',
        'ownerId': 'user-1',
        'title': 'Prompt title',
        'promptText': 'Write about [TOPIC].',
        'description': 'Short description',
        'notes': 'Internal notes',
        'category': 'Writing',
        'tags': <String>['draft', 'blog'],
        'status': 'ready',
        'variables': <String>['TOPIC'],
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'schemaVersion': 1,
      };
    }

    test('creates dto from map', () {
      final dto = PromptCardDto.fromMap(fullMap());

      expect(dto.id, 'prompt-1');
      expect(dto.ownerId, 'user-1');
      expect(dto.title, 'Prompt title');
      expect(dto.promptText, 'Write about [TOPIC].');
      expect(dto.description, 'Short description');
      expect(dto.notes, 'Internal notes');
      expect(dto.category, 'Writing');
      expect(dto.tags, <String>['draft', 'blog']);
      expect(dto.status, 'ready');
      expect(dto.variables, <String>['TOPIC']);
      expect(dto.createdAt, createdAt);
      expect(dto.updatedAt, updatedAt);
      expect(dto.schemaVersion, 1);
    });

    test('converts dto to map', () {
      final dto = PromptCardDto.fromMap(fullMap());

      expect(dto.toMap(), fullMap());
    });

    test('uses fallback schemaVersion when missing', () {
      final map = fullMap()..remove('schemaVersion');

      expect(PromptCardDto.fromMap(map).schemaVersion, 1);
    });

    test('uses empty tags fallback when missing', () {
      final map = fullMap()..remove('tags');

      expect(PromptCardDto.fromMap(map).tags, isEmpty);
    });

    test('uses empty variables fallback when missing', () {
      final map = fullMap()..remove('variables');

      expect(PromptCardDto.fromMap(map).variables, isEmpty);
    });
  });
}
