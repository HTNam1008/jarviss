// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'update_assistant_new_thread_playground_response.g.dart';

@JsonSerializable()
class UpdateAssistantNewThreadPlayGroundResponse {
    String assistantName;
    String createdAt;
    String? deletedAt;
    String? createdBy;
    String? description;
    String id;
    String? instructions;
    bool isDefault;
    bool isFavorite;
    String openAiAssistantId;
    String openAiThreadIdPlay;
    String? openAiVectorStoreId;
    String? updatedAt;
    String? updatedBy;
    String? userId;

  UpdateAssistantNewThreadPlayGroundResponse({
    required this.assistantName,
    required this.createdAt,
    this.deletedAt,
    this.createdBy,
    this.description,
    required this.id,
    this.instructions,
    required this.isDefault,
    required this.isFavorite,
    required this.openAiAssistantId,
    required this.openAiThreadIdPlay,
    this.openAiVectorStoreId,
    this.updatedAt,
    this.updatedBy,
    this.userId,
  });

  factory UpdateAssistantNewThreadPlayGroundResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateAssistantNewThreadPlayGroundResponseFromJson(json);
      
  Map<String, dynamic> toJson() => _$UpdateAssistantNewThreadPlayGroundResponseToJson(this);
}
