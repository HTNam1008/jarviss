import 'package:json_annotation/json_annotation.dart';

part 'update_assistant_response.g.dart';

@JsonSerializable()
class UpdateAssistantResponse {
    String assistantName;
    String createdAt;
    String? createdBy;
    String? description;
    String id;
    String? instructions;
    String openAiAssistantId;
    String? openAiThreadIdPlay;
    String? updatedAt;
    String? updatedBy;

  UpdateAssistantResponse({
    required this.assistantName,
    required this.createdAt,
    this.createdBy,
    this.description,
    required this.id,
    this.instructions,
    required this.openAiAssistantId,
    this.openAiThreadIdPlay,
    this.updatedAt,
    this.updatedBy,
  });

  factory UpdateAssistantResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateAssistantResponseFromJson(json);
      
  Map<String, dynamic> toJson() => _$UpdateAssistantResponseToJson(this);
}
