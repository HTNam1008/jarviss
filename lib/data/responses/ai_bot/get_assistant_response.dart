import 'package:json_annotation/json_annotation.dart';

part 'get_assistant_response.g.dart';

@JsonSerializable()
class GetAssistantResponse {
  final String createdAt;
  final String updatedAt;
  final String? createdBy;
  final String? updatedBy;
  final String? deletedAt;
  final String id;
  final String openAiAssistantId;
  final String description;
  final String instructions;
  final String assistantName;
  final String userId;
  final String openAiVectorStoreId;
  final String openAiThreadIdPlay;
  final bool isDefault;
  final bool isFavorite;

  GetAssistantResponse({
    required this.createdAt,
    required this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.deletedAt,
    required this.id,
    required this.openAiAssistantId, 
    required this.description,
    required this.instructions,
    required this.assistantName,
    required this.userId,
    required this.openAiVectorStoreId,
    required this.openAiThreadIdPlay,
    required this.isDefault,
    required this.isFavorite,
  });

  factory GetAssistantResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAssistantResponseFromJson(json);
      
  Map<String, dynamic> toJson() => _$GetAssistantResponseToJson(this);
}