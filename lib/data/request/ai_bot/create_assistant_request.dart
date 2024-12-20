// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'create_assistant_request.g.dart';

@JsonSerializable()
class CreateAssistantResponse {
  String assistantName;
  String? description;
  String? instructions;

  CreateAssistantResponse({
    required this.assistantName,
    this.description,
    this.instructions,
  });

  factory CreateAssistantResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateAssistantResponseFromJson(json);
      
  Map<String, dynamic> toJson() => _$CreateAssistantResponseToJson(this);
}
