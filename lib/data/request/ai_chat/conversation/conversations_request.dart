// ignore_for_file: public_member_api_docs, sort_constructors_first
// lib/data/request/ai_chat_request.dart

import 'package:json_annotation/json_annotation.dart';

part 'conversations_request.g.dart';

@JsonSerializable()
class ConversationsRequest {
  final String assistandId;
  final String assistantModel;
  final String? cursor;

  ConversationsRequest({
    required this.assistandId,
    required this.assistantModel,
    this.cursor,
  });
  
  factory ConversationsRequest.fromJson(Map<String, dynamic> json) =>
      _$ConversationsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationsRequestToJson(this);
}
