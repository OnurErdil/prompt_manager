import 'package:flutter_test/flutter_test.dart';
import 'package:prompt_manager/features/prompts/domain/entities/prompt_card.dart';
import 'package:prompt_manager/features/prompts/domain/enums/prompt_status.dart';

void main() {
  group('PromptCard', () {
    test('uses default values for optional domain fields', () {
      final card = _createPromptCard();

      expect(card.status, PromptStatus.raw);
      expect(card.tags, isEmpty);
      expect(card.variables, isEmpty);
      expect(card.schemaVersion, 1);
    });

    test('throws when promptText is empty', () {
      expect(
        () => _createPromptCard(promptText: ''),
        throwsA(isA<ArgumentError>()),
      );
      expect(
        () => _createPromptCard(promptText: '   '),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('effectiveTitle returns title when title exists', () {
      final card = _createPromptCard(title: 'Net başlık');

      expect(card.effectiveTitle, 'Net başlık');
    });

    test('effectiveTitle falls back to promptText when title is empty', () {
      final card = _createPromptCard(title: '  ', promptText: 'Kısa prompt');

      expect(card.effectiveTitle, 'Kısa prompt');
    });

    test('effectiveTitle truncates long promptText fallback', () {
      final longPrompt = 'a' * 61;
      final card = _createPromptCard(promptText: longPrompt);

      expect(card.effectiveTitle, '${'a' * 60}...');
    });

    test('hasVariables returns true when variables exist', () {
      final card = _createPromptCard(variables: ['KONU']);

      expect(card.hasVariables, isTrue);
    });

    test('hasVariables returns false when variables are empty', () {
      final card = _createPromptCard();

      expect(card.hasVariables, isFalse);
    });

    test('isArchived returns true when status is archived', () {
      final card = _createPromptCard(status: PromptStatus.archived);

      expect(card.isArchived, isTrue);
    });

    test('isArchived returns false when status is not archived', () {
      final card = _createPromptCard(status: PromptStatus.ready);

      expect(card.isArchived, isFalse);
    });

    test('copyWith updates selected fields and keeps the rest', () {
      final createdAt = DateTime(2026, 5, 29, 10);
      final updatedAt = DateTime(2026, 5, 29, 11);
      final card = _createPromptCard(
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
      final copied = card.copyWith(
        title: 'Yeni başlık',
        status: PromptStatus.ready,
        tags: ['m2'],
        variables: ['KONU'],
      );

      expect(copied.id, card.id);
      expect(copied.ownerId, card.ownerId);
      expect(copied.promptText, card.promptText);
      expect(copied.createdAt, createdAt);
      expect(copied.updatedAt, updatedAt);
      expect(copied.title, 'Yeni başlık');
      expect(copied.status, PromptStatus.ready);
      expect(copied.tags, ['m2']);
      expect(copied.variables, ['KONU']);
    });

    test('copyWith can clear nullable fields', () {
      final card = _createPromptCard(
        title: 'Başlık',
        description: 'Açıklama',
        notes: 'Not',
        category: 'Kategori',
      );
      final copied = card.copyWith(
        title: null,
        description: null,
        notes: null,
        category: null,
      );

      expect(copied.title, isNull);
      expect(copied.description, isNull);
      expect(copied.notes, isNull);
      expect(copied.category, isNull);
    });
  });
}

PromptCard _createPromptCard({
  String id = 'prompt-1',
  String ownerId = 'user-1',
  String? title,
  String promptText = 'Prompt metni',
  String? description,
  String? notes,
  String? category,
  List<String> tags = const [],
  PromptStatus status = PromptStatus.raw,
  List<String> variables = const [],
  DateTime? createdAt,
  DateTime? updatedAt,
  int schemaVersion = 1,
}) {
  final now = DateTime(2026, 5, 29, 12);

  return PromptCard(
    id: id,
    ownerId: ownerId,
    title: title,
    promptText: promptText,
    description: description,
    notes: notes,
    category: category,
    tags: tags,
    status: status,
    variables: variables,
    createdAt: createdAt ?? now,
    updatedAt: updatedAt ?? now,
    schemaVersion: schemaVersion,
  );
}
