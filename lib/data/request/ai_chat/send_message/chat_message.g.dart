// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) => ChatMessage(
      assistant: Assistant.fromJson(json['assistant'] as Map<String, dynamic>),
      content: json['content'] as String,
      files:
          (json['files'] as List<dynamic>?)?.map((e) => e as String).toList(),
      role: $enumDecode(_$MessageRoleEnumMap, json['role']),
    );

Map<String, dynamic> _$ChatMessageToJson(ChatMessage instance) {
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
  val['role'] = _$MessageRoleEnumMap[instance.role]!;
  return val;
}

const _$MessageRoleEnumMap = {
  MessageRole.user: 'user',
  MessageRole.model: 'model',
};
