// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'ask_assistant_request.g.dart';

@JsonSerializable()
class AskAssistantRequest {
  String assistandId;
  String message;
  String openAiThreadId;
  String additionalInstruction;

  AskAssistantRequest({
    required this.assistandId,
    required this.message,
    required this.openAiThreadId,
    required this.additionalInstruction,
  });

  factory AskAssistantRequest.fromJson(Map<String, dynamic> json) =>
      _$AskAssistantRequestFromJson(json);
      
  Map<String, dynamic> toJson() => _$AskAssistantRequestToJson(this);
}
