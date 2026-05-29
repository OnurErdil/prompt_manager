import 'package:flutter_test/flutter_test.dart';
import 'package:prompt_manager/features/prompts/domain/services/prompt_variable_parser.dart';

void main() {
  const parser = PromptVariableParser();

  group('PromptVariableParser', () {
    test('returns an empty list when there are no variables', () {
      expect(parser.parse('Değişken içermeyen prompt metni.'), isEmpty);
    });

    test('parses a single variable', () {
      expect(parser.parse('[KONU] hakkında yaz.'), ['KONU']);
    });

    test('parses multiple variables', () {
      expect(parser.parse('[KONU] için [TON] tonunda yaz.'), ['KONU', 'TON']);
    });

    test('deduplicates repeated variables', () {
      expect(parser.parse('[KONU] için [KONU] özetle.'), ['KONU']);
    });

    test('preserves variable order', () {
      expect(parser.parse('[BIR] [IKI] [UC]'), ['BIR', 'IKI', 'UC']);
    });

    test('ignores missing bracket expressions', () {
      expect(parser.parse('[KONU] [EKSIK'), ['KONU']);
    });

    test('ignores empty bracket expressions', () {
      expect(parser.parse('[] [KONU] []'), ['KONU']);
    });

    test('ignores variable-like expressions with spaces', () {
      expect(parser.parse('[KONU ADI] [KONU_ADI]'), ['KONU_ADI']);
    });

    test('supports Turkish characters', () {
      expect(parser.parse('[İŞ_TÜRÜ] ve [ÇÖZÜM]'), ['İŞ_TÜRÜ', 'ÇÖZÜM']);
    });

    test('supports underscores and numbers', () {
      expect(parser.parse('[HEDEF_1] [KATEGORI_2026]'), [
        'HEDEF_1',
        'KATEGORI_2026',
      ]);
    });

    test('does not normalize variable names', () {
      expect(parser.parse('[Konu] [KONU]'), ['Konu', 'KONU']);
    });
  });
}
