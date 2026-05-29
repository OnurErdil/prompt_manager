import '../enums/prompt_status.dart';

const _unset = Object();

class PromptCard {
  PromptCard({
    required this.id,
    required this.ownerId,
    this.title,
    required this.promptText,
    this.description,
    this.notes,
    this.category,
    List<String> tags = const [],
    this.status = PromptStatus.raw,
    List<String> variables = const [],
    required this.createdAt,
    required this.updatedAt,
    this.schemaVersion = 1,
  }) : tags = List.unmodifiable(tags),
       variables = List.unmodifiable(variables) {
    if (promptText.trim().isEmpty) {
      throw ArgumentError.value(
        promptText,
        'promptText',
        'Prompt text cannot be empty.',
      );
    }
  }

  final String id;
  final String ownerId;
  final String? title;
  final String promptText;
  final String? description;
  final String? notes;
  final String? category;
  final List<String> tags;
  final PromptStatus status;
  final List<String> variables;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int schemaVersion;

  bool get hasVariables => variables.isNotEmpty;

  bool get isArchived => status == PromptStatus.archived;

  String get effectiveTitle {
    final trimmedTitle = title?.trim();

    if (trimmedTitle != null && trimmedTitle.isNotEmpty) {
      return trimmedTitle;
    }

    final fallback = promptText.trim();

    if (fallback.length <= 60) {
      return fallback;
    }

    return '${fallback.substring(0, 60)}...';
  }

  PromptCard copyWith({
    String? id,
    String? ownerId,
    Object? title = _unset,
    String? promptText,
    Object? description = _unset,
    Object? notes = _unset,
    Object? category = _unset,
    List<String>? tags,
    PromptStatus? status,
    List<String>? variables,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? schemaVersion,
  }) {
    return PromptCard(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      title: title == _unset ? this.title : title as String?,
      promptText: promptText ?? this.promptText,
      description: description == _unset
          ? this.description
          : description as String?,
      notes: notes == _unset ? this.notes : notes as String?,
      category: category == _unset ? this.category : category as String?,
      tags: tags ?? this.tags,
      status: status ?? this.status,
      variables: variables ?? this.variables,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      schemaVersion: schemaVersion ?? this.schemaVersion,
    );
  }
}
