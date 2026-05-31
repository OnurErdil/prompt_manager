import '../../domain/entities/prompt_card.dart';
import '../../domain/enums/prompt_status.dart';

const _unset = Object();

enum PromptLibraryStatusFilter {
  active('active'),
  raw('raw'),
  needsEdit('needs_edit'),
  ready('ready'),
  archived('archived');

  const PromptLibraryStatusFilter(this.key);

  final String key;
}

class PromptLibraryFilterState {
  const PromptLibraryFilterState({
    this.query = '',
    this.statusFilter = PromptLibraryStatusFilter.active,
    this.selectedCategory,
    this.selectedTag,
  });

  final String query;
  final PromptLibraryStatusFilter statusFilter;
  final String? selectedCategory;
  final String? selectedTag;

  bool get hasActiveFilters {
    return query.trim().isNotEmpty ||
        statusFilter != PromptLibraryStatusFilter.active ||
        _hasText(selectedCategory) ||
        _hasText(selectedTag);
  }

  PromptLibraryFilterState copyWith({
    String? query,
    PromptLibraryStatusFilter? statusFilter,
    Object? selectedCategory = _unset,
    Object? selectedTag = _unset,
  }) {
    return PromptLibraryFilterState(
      query: query ?? this.query,
      statusFilter: statusFilter ?? this.statusFilter,
      selectedCategory: selectedCategory == _unset
          ? this.selectedCategory
          : selectedCategory as String?,
      selectedTag: selectedTag == _unset
          ? this.selectedTag
          : selectedTag as String?,
    );
  }
}

class PromptLibraryFilterOptions {
  const PromptLibraryFilterOptions({
    required this.categories,
    required this.tags,
  });

  final List<String> categories;
  final List<String> tags;
}

List<PromptCard> filterPromptCards(
  List<PromptCard> prompts,
  PromptLibraryFilterState filter,
) {
  final query = _normalize(filter.query);
  final selectedCategory = _normalize(filter.selectedCategory);
  final selectedTag = _normalize(filter.selectedTag);

  return prompts
      .where((prompt) {
        if (!_matchesStatus(prompt, filter.statusFilter)) {
          return false;
        }

        if (selectedCategory.isNotEmpty &&
            _normalize(prompt.category) != selectedCategory) {
          return false;
        }

        if (selectedTag.isNotEmpty &&
            !prompt.tags.any((tag) => _normalize(tag) == selectedTag)) {
          return false;
        }

        if (query.isEmpty) {
          return true;
        }

        return _matchesQuery(prompt, query);
      })
      .toList(growable: false);
}

PromptLibraryFilterOptions buildPromptLibraryFilterOptions(
  List<PromptCard> prompts,
) {
  return PromptLibraryFilterOptions(
    categories: _uniqueSortedTextValues(
      prompts.map((prompt) => prompt.category),
    ),
    tags: _uniqueSortedTextValues(prompts.expand((prompt) => prompt.tags)),
  );
}

bool _matchesStatus(PromptCard prompt, PromptLibraryStatusFilter statusFilter) {
  return switch (statusFilter) {
    PromptLibraryStatusFilter.active => !prompt.isArchived,
    PromptLibraryStatusFilter.raw => prompt.status == PromptStatus.raw,
    PromptLibraryStatusFilter.needsEdit =>
      prompt.status == PromptStatus.needsEdit,
    PromptLibraryStatusFilter.ready => prompt.status == PromptStatus.ready,
    PromptLibraryStatusFilter.archived =>
      prompt.status == PromptStatus.archived,
  };
}

bool _matchesQuery(PromptCard prompt, String query) {
  final searchableValues = <String?>[
    prompt.title,
    prompt.promptText,
    prompt.description,
    prompt.notes,
    prompt.category,
    ...prompt.tags,
  ];

  return searchableValues.any((value) => _normalize(value).contains(query));
}

List<String> _uniqueSortedTextValues(Iterable<String?> values) {
  final valuesByKey = <String, String>{};

  for (final value in values) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      continue;
    }

    valuesByKey.putIfAbsent(_normalize(trimmed), () => trimmed);
  }

  final result = valuesByKey.values.toList();
  result.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
  return List<String>.unmodifiable(result);
}

bool _hasText(String? value) => value != null && value.trim().isNotEmpty;

String _normalize(String? value) => value?.trim().toLowerCase() ?? '';
