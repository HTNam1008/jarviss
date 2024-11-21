// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_message_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendMessageRequest _$SendMessageRequestFromJson(Map<String, dynamic> json) =>
    SendMessageRequest(
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

Map<String, dynamic> _$SendMessageRequestToJson(SendMessageRequest instance) {
  final val = <String, dynamic>{
    'assistant': instance.assistant,
    'content': instance.content,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('files', instance.files);
  val['metadata'] = instance.metadata;
  return val;
}
