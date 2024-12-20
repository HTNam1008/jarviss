// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'create_assistant_response.g.dart';

@JsonSerializable()
class CreateAssistantResponse {
    String assistantName;
    DateTime createdAt;
    String? createdBy;
    String? description;
    String id;
    String? instructions;
    String openAiAssistantId;
    String? openAiThreadIdPlay;
    DateTime? updatedAt;
    String? updatedBy;

  CreateAssistantResponse({
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

  factory CreateAssistantResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateAssistantResponseFromJson(json);
      
  Map<String, dynamic> toJson() => _$CreateAssistantResponseToJson(this);
}
