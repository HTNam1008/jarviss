// lib/data/request/ai_chat_request.dart

import 'package:json_annotation/json_annotation.dart';
import 'assistant.dart';
import 'send_message_metadata.dart';

part 'send_message_request.g.dart';

@JsonSerializable()
class SendMessageRequest {
  final Assistant? assistant;
  final String content;

  @JsonKey(includeIfNull: false)
  final List<String>? files;
  
  final SendMessageMetadata? metadata;

  SendMessageRequest({
    this.assistant,
    required this.content,
    this.files,
    this.metadata,
  });

  factory SendMessageRequest.fromJson(Map<String, dynamic> json) =>
      _$SendMessageRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendMessageRequestToJson(this);
}
