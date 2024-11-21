// lib/data/request/ai_chat_metadata.dart

import 'package:json_annotation/json_annotation.dart';
import 'chat_conversation.dart';

part 'send_message_metadata.g.dart';

@JsonSerializable()
class SendMessageMetadata {
  final ChatConversation? conversation;

  SendMessageMetadata({
   this.conversation,
  });

  factory SendMessageMetadata.fromJson(Map<String, dynamic> json) =>
      _$SendMessageMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$SendMessageMetadataToJson(this);
}
