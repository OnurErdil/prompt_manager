import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/repositories/firestore_prompt_repository.dart';
import '../../data/services/prompt_firestore_service.dart';
import '../../domain/entities/prompt_card.dart';
import '../../domain/repositories/prompt_repository.dart';
import '../../domain/services/prompt_variable_parser.dart';
import '../controllers/detailed_add_prompt_controller.dart';
import '../controllers/prompt_edit_controller.dart';
import '../controllers/quick_add_prompt_controller.dart';

final promptFirestoreServiceProvider = Provider<PromptFirestoreService>((ref) {
  return PromptFirestoreService();
});

final promptRepositoryProvider = Provider<PromptRepository>((ref) {
  final service = ref.watch(promptFirestoreServiceProvider);

  return FirestorePromptRepository(service: service);
});

final promptVariableParserProvider = Provider<PromptVariableParser>((ref) {
  return const PromptVariableParser();
});

final currentUserPromptsProvider = StreamProvider.autoDispose<List<PromptCard>>(
  (ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user == null) {
          return Stream<List<PromptCard>>.value(const <PromptCard>[]);
        }

        final repository = ref.watch(promptRepositoryProvider);
        return repository.watchPrompts(userId: user.id);
      },
      loading: () => Stream<List<PromptCard>>.value(const <PromptCard>[]),
      error: (error, stackTrace) =>
          Stream<List<PromptCard>>.error(error, stackTrace),
    );
  },
);

final promptDetailProvider = FutureProvider.autoDispose
    .family<PromptCard?, String>((ref, promptId) {
      final authRepository = ref.watch(authRepositoryProvider);
      final user = authRepository.currentUser;

      if (user == null || promptId.trim().isEmpty) {
        return Future<PromptCard?>.value();
      }

      final repository = ref.watch(promptRepositoryProvider);
      return repository.getPromptById(userId: user.id, promptId: promptId);
    });

final quickAddPromptControllerProvider =
    StateNotifierProvider.autoDispose<
      QuickAddPromptController,
      AsyncValue<void>
    >((ref) {
      final authRepository = ref.watch(authRepositoryProvider);
      final promptRepository = ref.watch(promptRepositoryProvider);
      final parser = ref.watch(promptVariableParserProvider);

      return QuickAddPromptController(
        authRepository: authRepository,
        promptRepository: promptRepository,
        parser: parser,
      );
    });

final detailedAddPromptControllerProvider =
    StateNotifierProvider.autoDispose<
      DetailedAddPromptController,
      AsyncValue<void>
    >((ref) {
      final authRepository = ref.watch(authRepositoryProvider);
      final promptRepository = ref.watch(promptRepositoryProvider);
      final parser = ref.watch(promptVariableParserProvider);

      return DetailedAddPromptController(
        authRepository: authRepository,
        promptRepository: promptRepository,
        parser: parser,
      );
    });

final promptEditControllerProvider =
    StateNotifierProvider.autoDispose<PromptEditController, AsyncValue<void>>((
      ref,
    ) {
      final authRepository = ref.watch(authRepositoryProvider);
      final promptRepository = ref.watch(promptRepositoryProvider);
      final parser = ref.watch(promptVariableParserProvider);

      return PromptEditController(
        authRepository: authRepository,
        promptRepository: promptRepository,
        parser: parser,
      );
    });
