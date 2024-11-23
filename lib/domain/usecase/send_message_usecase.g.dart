// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_message_usecase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendMessageUseCaseInput _$SendMessageUseCaseInputFromJson(
        Map<String, dynamic> json) =>
    SendMessageUseCaseInput(
      assistant: json['assistant'] == null
          ? null
          : Assistant.fromJson(json['assistant'] as Map<String, dynamic>),
      content: json['content'] as String,
      files:
          (json['files'] as List<dynamic>?)?.map((e) => e as String).toList(),
      metadata: json['metadata'] == null
          ? null
          : SendMessageMetadata.fromJson(
              json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SendMessageUseCaseInputToJson(
        SendMessageUseCaseInput instance) =>
    <String, dynamic>{
      'assistant': instance.assistant,
      'content': instance.content,
      'files': instance.files,
      'metadata': instance.metadata,
    };
