import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../auth/domain/repositories/auth_repository.dart';
import '../../domain/entities/prompt_card.dart';
import '../../domain/enums/prompt_status.dart';
import '../../domain/repositories/prompt_repository.dart';
import '../../domain/services/prompt_variable_parser.dart';

class PromptEditController extends StateNotifier<AsyncValue<void>> {
  PromptEditController({
    required AuthRepository authRepository,
    required PromptRepository promptRepository,
    required PromptVariableParser parser,
    DateTime Function()? now,
  }) : _authRepository = authRepository,
       _promptRepository = promptRepository,
       _parser = parser,
       _now = now ?? DateTime.now,
       super(const AsyncValue.data(null));

  final AuthRepository _authRepository;
  final PromptRepository _promptRepository;
  final PromptVariableParser _parser;
  final DateTime Function() _now;

  Future<void> updatePrompt({
    required PromptCard originalPrompt,
    required String title,
    required String promptText,
    required String description,
    required String notes,
    required String category,
    required String tagsInput,
    required PromptStatus status,
  }) async {
    final normalizedPromptText = promptText.trim();
    if (normalizedPromptText.isEmpty) {
      state = AsyncValue.error(
        const FormatException('Prompt metni bos olamaz.'),
        StackTrace.current,
      );
      return;
    }

    final user = _authRepository.currentUser;
    if (user == null) {
      state = AsyncValue.error(
        StateError('Prompt guncellemek icin giris yapmalisiniz.'),
        StackTrace.current,
      );
      return;
    }

    if (user.id != originalPrompt.ownerId) {
      state = AsyncValue.error(
        StateError('Bu promptu guncelleme yetkiniz yok.'),
        StackTrace.current,
      );
      return;
    }

    state = const AsyncValue.loading();

    try {
      final updatedPrompt = originalPrompt.copyWith(
        title: title.trim(),
        promptText: normalizedPromptText,
        description: description.trim(),
        notes: notes.trim(),
        category: category.trim(),
        tags: _parseTags(tagsInput),
        status: status,
        variables: _parser.parse(normalizedPromptText),
        updatedAt: _now(),
      );

      await _promptRepository.updatePrompt(updatedPrompt);

      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  static List<String> _parseTags(String tagsInput) {
    return tagsInput
        .split(',')
        .map((tag) => tag.trim())
        .where((tag) => tag.isNotEmpty)
        .toList(growable: false);
  }
}
