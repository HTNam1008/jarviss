// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'ask_assistant_response.g.dart';

@JsonSerializable()
class AskAssistantResponse {
    String message;

  AskAssistantResponse({
    required this.message,
  });

  factory AskAssistantResponse.fromJson(Map<String, dynamic> json) =>
      _$AskAssistantResponseFromJson(json);
      
  Map<String, dynamic> toJson() => _$AskAssistantResponseToJson(this);
}
