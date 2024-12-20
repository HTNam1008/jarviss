import 'package:json_annotation/json_annotation.dart';
part 'get_assistant_request.g.dart';

@JsonSerializable()
class GetAssistantRequest {
  final String assistantId;

  factory GetAssistantRequest.fromJson(Map<String, dynamic> json) =>
      _$GetAssistantRequestFromJson(json);

  GetAssistantRequest({required this.assistantId});
  
  Map<String, dynamic> toJson() => _$GetAssistantRequestToJson(this);
}
