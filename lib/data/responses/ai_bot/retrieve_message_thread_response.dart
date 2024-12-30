import 'package:json_annotation/json_annotation.dart';

part 'retrieve_message_thread_response.g.dart';

@JsonSerializable()
class RetrieveMessageThreadResponse {
  @JsonKey(name: 'messages')
  final List<MessageAssistantResponse> messages;

  RetrieveMessageThreadResponse({
    required this.messages,
  });

factory RetrieveMessageThreadResponse.fromJson(List<dynamic> json) {
    return RetrieveMessageThreadResponse(
      messages: json
          .map((message) => 
              MessageAssistantResponse.fromJson(message as Map<String, dynamic>))
          .toList(),
    );
  }

  // Map<String, dynamic> toJson() => {
  //       'messages': messages.map((message) => message.toJson()).toList(),
  //     };
}

@JsonSerializable()
class MessageAssistantResponse {
  final String role;
  final int createdAt;
  final List<MessageContent> content;

  MessageAssistantResponse({
    required this.role,
    required this.createdAt,
    required this.content,
  });

  factory MessageAssistantResponse.fromJson(Map<String, dynamic> json) =>
      _$MessageAssistantResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MessageAssistantResponseToJson(this);
}

@JsonSerializable()
class MessageContent {
  final String type;
  final MessageText text;

  MessageContent({
    required this.type,
    required this.text,
  });

  factory MessageContent.fromJson(Map<String, dynamic> json) =>
      _$MessageContentFromJson(json);
  Map<String, dynamic> toJson() => _$MessageContentToJson(this);
}

@JsonSerializable()
class MessageText {
  final String value;
  final List<dynamic> annotations;

  MessageText({
    required this.value,
    required this.annotations,
  });

  factory MessageText.fromJson(Map<String, dynamic> json) =>
      _$MessageTextFromJson(json);
  Map<String, dynamic> toJson() => _$MessageTextToJson(this);
}