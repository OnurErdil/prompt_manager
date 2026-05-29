class PromptCardDto {
  PromptCardDto({
    required this.id,
    required this.ownerId,
    this.title,
    required this.promptText,
    this.description,
    this.notes,
    this.category,
    List<String> tags = const [],
    required this.status,
    List<String> variables = const [],
    required this.createdAt,
    required this.updatedAt,
    this.schemaVersion = 1,
  }) : tags = List.unmodifiable(tags),
       variables = List.unmodifiable(variables);

  final String id;
  final String ownerId;
  final String? title;
  final String promptText;
  final String? description;
  final String? notes;
  final String? category;
  final List<String> tags;
  final String status;
  final List<String> variables;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int schemaVersion;

  factory PromptCardDto.fromMap(Map<String, dynamic> map) {
    return PromptCardDto(
      id: map['id'] as String,
      ownerId: map['ownerId'] as String,
      title: map['title'] as String?,
      promptText: map['promptText'] as String,
      description: map['description'] as String?,
      notes: map['notes'] as String?,
      category: map['category'] as String?,
      tags: _stringListFrom(map['tags']),
      status: map['status'] as String,
      variables: _stringListFrom(map['variables']),
      createdAt: _dateTimeFrom(map['createdAt']),
      updatedAt: _dateTimeFrom(map['updatedAt']),
      schemaVersion: map['schemaVersion'] as int? ?? 1,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'ownerId': ownerId,
      'title': title,
      'promptText': promptText,
      'description': description,
      'notes': notes,
      'category': category,
      'tags': List<String>.of(tags),
      'status': status,
      'variables': List<String>.of(variables),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'schemaVersion': schemaVersion,
    };
  }

  static List<String> _stringListFrom(Object? value) {
    if (value is! List) {
      return <String>[];
    }

    return value.whereType<String>().toList(growable: false);
  }

  static DateTime _dateTimeFrom(Object? value) {
    if (value is DateTime) {
      return value;
    }

    throw ArgumentError.value(value, 'value', 'Expected a DateTime value.');
  }
}
