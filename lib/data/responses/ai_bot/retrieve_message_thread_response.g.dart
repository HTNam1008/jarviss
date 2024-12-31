// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retrieve_message_thread_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RetrieveMessageThreadResponse _$RetrieveMessageThreadResponseFromJson(
        Map<String, dynamic> json) =>
    RetrieveMessageThreadResponse(
      messages: (json['messages'] as List<dynamic>)
          .map((e) =>
              MessageAssistantResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RetrieveMessageThreadResponseToJson(
        RetrieveMessageThreadResponse instance) =>
    <String, dynamic>{
      'messages': instance.messages,
    };

MessageAssistantResponse _$MessageAssistantResponseFromJson(
        Map<String, dynamic> json) =>
    MessageAssistantResponse(
      role: json['role'] as String,
      createdAt: (json['createdAt'] as num).toInt(),
      content: (json['content'] as List<dynamic>)
          .map((e) => MessageContent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MessageAssistantResponseToJson(
        MessageAssistantResponse instance) =>
    <String, dynamic>{
      'role': instance.role,
      'createdAt': instance.createdAt,
      'content': instance.content,
    };

MessageContent _$MessageContentFromJson(Map<String, dynamic> json) =>
    MessageContent(
      type: json['type'] as String,
      text: MessageText.fromJson(json['text'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageContentToJson(MessageContent instance) =>
    <String, dynamic>{
      'type': instance.type,
      'text': instance.text,
    };

MessageText _$MessageTextFromJson(Map<String, dynamic> json) => MessageText(
      value: json['value'] as String,
      annotations: json['annotations'] as List<dynamic>,
    );

Map<String, dynamic> _$MessageTextToJson(MessageText instance) =>
    <String, dynamic>{
      'value': instance.value,
      'annotations': instance.annotations,
    };
