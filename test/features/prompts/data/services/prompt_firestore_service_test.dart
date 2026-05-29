import 'package:flutter_test/flutter_test.dart';
import 'package:prompt_manager/features/prompts/data/services/prompt_firestore_service.dart';

void main() {
  group('PromptFirestoreService', () {
    test('builds user scoped prompts collection path', () {
      expect(
        PromptFirestoreService.promptsCollectionPath('user-1'),
        'users/user-1/prompts',
      );
    });

    test('builds user scoped prompt document path', () {
      expect(
        PromptFirestoreService.promptDocumentPath(
          userId: 'user-1',
          promptId: 'prompt-1',
        ),
        'users/user-1/prompts/prompt-1',
      );
    });
  });
}
