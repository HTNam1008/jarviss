import 'package:json_annotation/json_annotation.dart';
part 'delete_assistant_request.g.dart';

@JsonSerializable()
class DeleteAssistantRequest {
  final String assistantId;

  factory DeleteAssistantRequest.fromJson(Map<String, dynamic> json) =>
      _$DeleteAssistantRequestFromJson(json);

  DeleteAssistantRequest({required this.assistantId});

  Map<String, dynamic> toJson() => _$DeleteAssistantRequestToJson(this);
}
