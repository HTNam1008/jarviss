// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_message_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendMessageResponse _$SendMessageResponseFromJson(Map<String, dynamic> json) =>
    SendMessageResponse(
      conversationId: json['conversationId'] as String,
      message: json['message'] as String,
      remainingUsage: (json['remainingUsage'] as num).toInt(),
    );

Map<String, dynamic> _$SendMessageResponseToJson(
        SendMessageResponse instance) =>
    <String, dynamic>{
      'conversationId': instance.conversationId,
      'message': instance.message,
      'remainingUsage': instance.remainingUsage,
    };
