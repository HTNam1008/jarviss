import 'package:json_annotation/json_annotation.dart';

part 'create_assistant_request.g.dart';

@JsonSerializable()
class CreateAssistantRequest {
  String assistantName;
  String? description;
  String? instructions;

  CreateAssistantRequest({
    required this.assistantName,
    this.description,
    this.instructions,
  });

  factory CreateAssistantRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateAssistantRequestFromJson(json);
      
  Map<String, dynamic> toJson() => _$CreateAssistantRequestToJson(this);
}
