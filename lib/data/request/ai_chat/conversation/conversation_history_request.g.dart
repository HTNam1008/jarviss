// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_history_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationHistoryRequest _$ConversationHistoryRequestFromJson(
        Map<String, dynamic> json) =>
    ConversationHistoryRequest(
      conversationId: json['conversationId'] as String,
      assistandId: json['assistandId'] as String,
      assistantModel: json['assistantModel'] as String,
      cursor: json['cursor'] as String?,
    );

Map<String, dynamic> _$ConversationHistoryRequestToJson(
        ConversationHistoryRequest instance) =>
    <String, dynamic>{
      'conversationId': instance.conversationId,
      'assistandId': instance.assistandId,
      'assistantModel': instance.assistantModel,
      'cursor': instance.cursor,
    };
