// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'update_assistant_new_thread_playground_request.g.dart';

@JsonSerializable()
class UpdateAssistantNewThreadPlayGroundRequest {
  String assistantId;
  String firstMessage;

  UpdateAssistantNewThreadPlayGroundRequest({
    required this.assistantId,
    this.firstMessage = '',
  });

  factory UpdateAssistantNewThreadPlayGroundRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateAssistantNewThreadPlayGroundRequestFromJson(json);
      
  Map<String, dynamic> toJson() => _$UpdateAssistantNewThreadPlayGroundRequestToJson(this);
}
