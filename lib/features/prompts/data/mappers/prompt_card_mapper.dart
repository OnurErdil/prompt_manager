import '../../domain/entities/prompt_card.dart';
import '../../domain/enums/prompt_status.dart';
import '../dtos/prompt_card_dto.dart';

extension PromptCardMapper on PromptCard {
  PromptCardDto toDto() {
    return PromptCardDto(
      id: id,
      ownerId: ownerId,
      title: title,
      promptText: promptText,
      description: description,
      notes: notes,
      category: category,
      tags: List<String>.of(tags),
      status: status.toKey(),
      variables: List<String>.of(variables),
      createdAt: createdAt,
      updatedAt: updatedAt,
      schemaVersion: schemaVersion,
    );
  }
}

extension PromptCardDtoMapper on PromptCardDto {
  PromptCard toDomain() {
    return PromptCard(
      id: id,
      ownerId: ownerId,
      title: title,
      promptText: promptText,
      description: description,
      notes: notes,
      category: category,
      tags: List<String>.of(tags),
      status: PromptStatus.fromKey(status),
      variables: List<String>.of(variables),
      createdAt: createdAt,
      updatedAt: updatedAt,
      schemaVersion: schemaVersion,
    );
  }
}
