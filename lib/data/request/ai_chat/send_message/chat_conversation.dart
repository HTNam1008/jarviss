// lib/data/request/chat_conversation.dart

import 'package:json_annotation/json_annotation.dart';
import 'chat_message.dart';

part 'chat_conversation.g.dart';

@JsonSerializable()
class ChatConversation {
  @JsonKey(includeIfNull: false)
  final String? id;
  
  @JsonKey(includeIfNull: false)
  final List<ChatMessage>? messages;

  ChatConversation({
    this.id,
    this.messages,
  });

  factory ChatConversation.fromJson(Map<String, dynamic> json) =>
      _$ChatConversationFromJson(json);

  Map<String, dynamic> toJson() => _$ChatConversationToJson(this);
}
