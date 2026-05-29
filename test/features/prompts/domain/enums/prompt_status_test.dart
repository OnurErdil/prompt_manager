import 'package:flutter_test/flutter_test.dart';
import 'package:prompt_manager/features/prompts/domain/enums/prompt_status.dart';

void main() {
  group('PromptStatus', () {
    test('converts status values to technical keys', () {
      expect(PromptStatus.raw.toKey(), 'raw');
      expect(PromptStatus.needsEdit.toKey(), 'needs_edit');
      expect(PromptStatus.ready.toKey(), 'ready');
      expect(PromptStatus.archived.toKey(), 'archived');
    });

    test('converts technical keys to status values', () {
      expect(PromptStatus.fromKey('raw'), PromptStatus.raw);
      expect(PromptStatus.fromKey('needs_edit'), PromptStatus.needsEdit);
      expect(PromptStatus.fromKey('ready'), PromptStatus.ready);
      expect(PromptStatus.fromKey('archived'), PromptStatus.archived);
    });

    test('falls back to raw for invalid status keys', () {
      expect(PromptStatus.fromKey('invalid'), PromptStatus.raw);
      expect(PromptStatus.fromKey(null), PromptStatus.raw);
      expect(PromptStatus.fromKey(''), PromptStatus.raw);
    });
  });
}
