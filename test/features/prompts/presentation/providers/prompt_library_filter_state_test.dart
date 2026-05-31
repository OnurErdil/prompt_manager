import 'package:flutter_test/flutter_test.dart';
import 'package:prompt_manager/features/prompts/domain/entities/prompt_card.dart';
import 'package:prompt_manager/features/prompts/domain/enums/prompt_status.dart';
import 'package:prompt_manager/features/prompts/presentation/providers/prompt_library_filter_state.dart';

void main() {
  group('filterPromptCards', () {
    test('hides archived prompts by default', () {
      final result = filterPromptCards(
        _prompts(),
        const PromptLibraryFilterState(),
      );

      expect(result.map((prompt) => prompt.id), <String>[
        'raw-1',
        'needs-edit-1',
        'ready-1',
      ]);
    });

    test('shows only archived prompts when archived status is selected', () {
      final result = filterPromptCards(
        _prompts(),
        const PromptLibraryFilterState(
          statusFilter: PromptLibraryStatusFilter.archived,
        ),
      );

      expect(result.map((prompt) => prompt.id), <String>['archived-1']);
    });

    test('filters raw, needs_edit, and ready statuses', () {
      expect(
        filterPromptCards(
          _prompts(),
          const PromptLibraryFilterState(
            statusFilter: PromptLibraryStatusFilter.raw,
          ),
        ).map((prompt) => prompt.id),
        <String>['raw-1'],
      );
      expect(
        filterPromptCards(
          _prompts(),
          const PromptLibraryFilterState(
            statusFilter: PromptLibraryStatusFilter.needsEdit,
          ),
        ).map((prompt) => prompt.id),
        <String>['needs-edit-1'],
      );
      expect(
        filterPromptCards(
          _prompts(),
          const PromptLibraryFilterState(
            statusFilter: PromptLibraryStatusFilter.ready,
          ),
        ).map((prompt) => prompt.id),
        <String>['ready-1'],
      );
    });

    test('searches title case-insensitively', () {
      final result = filterPromptCards(
        _prompts(),
        const PromptLibraryFilterState(query: 'launch title'),
      );

      expect(result.map((prompt) => prompt.id), <String>['raw-1']);
    });

    test('searches prompt text case-insensitively', () {
      final result = filterPromptCards(
        _prompts(),
        const PromptLibraryFilterState(query: 'newsletter'),
      );

      expect(result.map((prompt) => prompt.id), <String>['needs-edit-1']);
    });

    test('searches description, notes, category, and tags', () {
      expect(
        filterPromptCards(
          _prompts(),
          const PromptLibraryFilterState(query: 'brief description'),
        ).map((prompt) => prompt.id),
        <String>['raw-1'],
      );
      expect(
        filterPromptCards(
          _prompts(),
          const PromptLibraryFilterState(query: 'meeting notes'),
        ).map((prompt) => prompt.id),
        <String>['needs-edit-1'],
      );
      expect(
        filterPromptCards(
          _prompts(),
          const PromptLibraryFilterState(query: 'strategy'),
        ).map((prompt) => prompt.id),
        <String>['ready-1'],
      );
      expect(
        filterPromptCards(
          _prompts(),
          const PromptLibraryFilterState(query: 'planning'),
        ).map((prompt) => prompt.id),
        <String>['ready-1'],
      );
    });

    test('filters by category', () {
      final result = filterPromptCards(
        _prompts(),
        const PromptLibraryFilterState(selectedCategory: 'Writing'),
      );

      expect(result.map((prompt) => prompt.id), <String>[
        'raw-1',
        'needs-edit-1',
      ]);
    });

    test('filters by tag', () {
      final result = filterPromptCards(
        _prompts(),
        const PromptLibraryFilterState(selectedTag: 'launch'),
      );

      expect(result.map((prompt) => prompt.id), <String>['raw-1']);
    });

    test('combines search and filters', () {
      final result = filterPromptCards(
        _prompts(),
        const PromptLibraryFilterState(
          query: 'newsletter',
          statusFilter: PromptLibraryStatusFilter.needsEdit,
          selectedCategory: 'Writing',
          selectedTag: 'email',
        ),
      );

      expect(result.map((prompt) => prompt.id), <String>['needs-edit-1']);
    });
  });

  group('buildPromptLibraryFilterOptions', () {
    test('trims, deduplicates, and sorts categories and tags', () {
      final options = buildPromptLibraryFilterOptions(<PromptCard>[
        _prompt(
          id: '1',
          category: ' Writing ',
          tags: <String>[' launch ', '', 'Email'],
        ),
        _prompt(
          id: '2',
          category: 'writing',
          tags: <String>['email', 'planning'],
        ),
        _prompt(id: '3', category: 'Strategy', tags: <String>['  ']),
      ]);

      expect(options.categories, <String>['Strategy', 'Writing']);
      expect(options.tags, <String>['Email', 'launch', 'planning']);
    });
  });
}

List<PromptCard> _prompts() {
  return <PromptCard>[
    _prompt(
      id: 'raw-1',
      title: 'Launch title',
      promptText: 'Write a launch plan.',
      description: 'Brief description',
      category: 'Writing',
      tags: <String>['launch'],
    ),
    _prompt(
      id: 'needs-edit-1',
      title: 'Email draft',
      promptText: 'Create a newsletter.',
      notes: 'Meeting notes',
      category: 'Writing',
      tags: <String>['email'],
      status: PromptStatus.needsEdit,
    ),
    _prompt(
      id: 'ready-1',
      title: 'Planning card',
      promptText: 'Summarize the roadmap.',
      category: 'Strategy',
      tags: <String>['planning'],
      status: PromptStatus.ready,
    ),
    _prompt(
      id: 'archived-1',
      title: 'Old prompt',
      promptText: 'Archived prompt text.',
      status: PromptStatus.archived,
    ),
  ];
}

PromptCard _prompt({
  required String id,
  String title = 'Title',
  String promptText = 'Prompt text',
  String? description,
  String? notes,
  String? category,
  List<String> tags = const <String>[],
  PromptStatus status = PromptStatus.raw,
}) {
  return PromptCard(
    id: id,
    ownerId: 'user-1',
    title: title,
    promptText: promptText,
    description: description,
    notes: notes,
    category: category,
    tags: tags,
    status: status,
    createdAt: DateTime(2026, 5, 30),
    updatedAt: DateTime(2026, 5, 30),
  );
}
