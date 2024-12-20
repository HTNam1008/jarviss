// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'update_assistant_request.g.dart';

@JsonSerializable()
class UpdateAssistantRequest {
  String assistantId;
  String assistantName;
  String? description;
  String? instructions;

  UpdateAssistantRequest({
    required this.assistantId,
    required this.assistantName,
    this.description,
    this.instructions,
  });

  factory UpdateAssistantRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateAssistantRequestFromJson(json);
      
  Map<String, dynamic> toJson() => _$UpdateAssistantRequestToJson(this);
}
