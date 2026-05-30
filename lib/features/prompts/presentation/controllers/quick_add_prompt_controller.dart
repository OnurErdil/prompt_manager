import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../auth/domain/repositories/auth_repository.dart';
import '../../domain/entities/prompt_card.dart';
import '../../domain/enums/prompt_status.dart';
import '../../domain/repositories/prompt_repository.dart';
import '../../domain/services/prompt_variable_parser.dart';

typedef PromptIdGenerator = String Function(DateTime now);

class QuickAddPromptController extends StateNotifier<AsyncValue<void>> {
  QuickAddPromptController({
    required AuthRepository authRepository,
    required PromptRepository promptRepository,
    required PromptVariableParser parser,
    DateTime Function()? now,
    PromptIdGenerator? idGenerator,
  }) : _authRepository = authRepository,
       _promptRepository = promptRepository,
       _parser = parser,
       _now = now ?? DateTime.now,
       _idGenerator =
           idGenerator ?? ((now) => 'prompt_${now.microsecondsSinceEpoch}'),
       super(const AsyncValue.data(null));

  final AuthRepository _authRepository;
  final PromptRepository _promptRepository;
  final PromptVariableParser _parser;
  final DateTime Function() _now;
  final PromptIdGenerator _idGenerator;

  Future<void> createPrompt({required String promptText}) async {
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
        StateError('Prompt olusturmak icin giris yapmalisiniz.'),
        StackTrace.current,
      );
      return;
    }

    state = const AsyncValue.loading();

    try {
      final createdAt = _now();
      final prompt = PromptCard(
        id: _idGenerator(createdAt),
        ownerId: user.id,
        title: '',
        promptText: normalizedPromptText,
        description: '',
        notes: '',
        category: '',
        tags: const <String>[],
        status: PromptStatus.raw,
        variables: _parser.parse(normalizedPromptText),
        createdAt: createdAt,
        updatedAt: createdAt,
        schemaVersion: 1,
      );

      await _promptRepository.createPrompt(prompt);

      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
