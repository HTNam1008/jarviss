// lib/data/request/chat_message.dart

import 'package:jarvis/data/request/ai_chat/send_message/message_role.dart';
import 'package:json_annotation/json_annotation.dart';
import 'assistant.dart';

part 'chat_message.g.dart';

@JsonSerializable()
class ChatMessage {
  final Assistant assistant;
  final String content;

  @JsonKey(includeIfNull: false)
  final List<String>? files;
  final MessageRole role;

  ChatMessage({
    required this.assistant,
    required this.content,
    this.files,
    required this.role,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);
}
