import 'package:cloud_firestore/cloud_firestore.dart';

import '../dtos/prompt_card_dto.dart';

class PromptFirestoreService {
  PromptFirestoreService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  static String promptsCollectionPath(String userId) {
    return 'users/$userId/prompts';
  }

  static String promptDocumentPath({
    required String userId,
    required String promptId,
  }) {
    return '${promptsCollectionPath(userId)}/$promptId';
  }

  Future<void> createPrompt(PromptCardDto dto) {
    return _promptDocument(
      userId: dto.ownerId,
      promptId: dto.id,
    ).set(_toFirestoreMap(dto));
  }

  Stream<List<PromptCardDto>> watchPrompts({required String userId}) {
    return _promptsCollection(userId)
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((document) => _dtoFromSnapshot(document))
              .toList(growable: false),
        );
  }

  Future<PromptCardDto?> getPromptById({
    required String userId,
    required String promptId,
  }) async {
    final snapshot = await _promptDocument(
      userId: userId,
      promptId: promptId,
    ).get();

    if (!snapshot.exists) {
      return null;
    }

    return _dtoFromSnapshot(snapshot);
  }

  Future<void> updatePrompt(PromptCardDto dto) {
    return _promptDocument(
      userId: dto.ownerId,
      promptId: dto.id,
    ).set(_toFirestoreMap(dto));
  }

  CollectionReference<Map<String, dynamic>> _promptsCollection(String userId) {
    return _firestore.collection(promptsCollectionPath(userId));
  }

  DocumentReference<Map<String, dynamic>> _promptDocument({
    required String userId,
    required String promptId,
  }) {
    return _firestore.doc(
      promptDocumentPath(userId: userId, promptId: promptId),
    );
  }

  static PromptCardDto _dtoFromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    if (data == null) {
      throw StateError('Prompt document data is missing.');
    }

    final map = Map<String, dynamic>.of(data);
    map['id'] = map['id'] ?? snapshot.id;
    return PromptCardDto.fromMap(_dateTimesFromFirestoreMap(map));
  }

  static Map<String, dynamic> _toFirestoreMap(PromptCardDto dto) {
    final map = dto.toMap();
    map['createdAt'] = Timestamp.fromDate(dto.createdAt);
    map['updatedAt'] = Timestamp.fromDate(dto.updatedAt);
    return map;
  }

  static Map<String, dynamic> _dateTimesFromFirestoreMap(
    Map<String, dynamic> map,
  ) {
    return map.map((key, value) {
      if (value is Timestamp) {
        return MapEntry<String, dynamic>(key, value.toDate());
      }

      return MapEntry<String, dynamic>(key, value);
    });
  }
}
