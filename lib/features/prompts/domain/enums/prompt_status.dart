enum PromptStatus {
  raw('raw'),
  needsEdit('needs_edit'),
  ready('ready'),
  archived('archived');

  const PromptStatus(this.key);

  final String key;

  String toKey() => key;

  static PromptStatus fromKey(String? key) {
    for (final status in PromptStatus.values) {
      if (status.key == key) {
        return status;
      }
    }

    return PromptStatus.raw;
  }
}
