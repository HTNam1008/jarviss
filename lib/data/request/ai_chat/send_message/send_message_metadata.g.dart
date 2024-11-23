// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_message_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendMessageMetadata _$SendMessageMetadataFromJson(Map<String, dynamic> json) =>
    SendMessageMetadata(
      conversation: json['conversation'] == null
          ? null
          : ChatConversation.fromJson(
              json['conversation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SendMessageMetadataToJson(
        SendMessageMetadata instance) =>
    <String, dynamic>{
      'conversation': instance.conversation,
    };
