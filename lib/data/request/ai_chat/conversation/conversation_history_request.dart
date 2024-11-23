// ignore_for_file: public_member_api_docs, sort_constructors_first
// lib/data/request/ai_chat_request.dart

import 'package:json_annotation/json_annotation.dart';

part 'conversation_history_request.g.dart';

@JsonSerializable()
class ConversationHistoryRequest {
  final String conversationId;
  final String assistandId;
  final String assistantModel;
  final String? cursor;

  ConversationHistoryRequest({
    required this.conversationId,
    required this.assistandId,
    required this.assistantModel,
    this.cursor,
  });
  
  factory ConversationHistoryRequest.fromJson(Map<String, dynamic> json) =>
      _$ConversationHistoryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationHistoryRequestToJson(this);
}
