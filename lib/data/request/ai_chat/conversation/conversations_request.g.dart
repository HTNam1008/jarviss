// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversations_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationsRequest _$ConversationsRequestFromJson(
        Map<String, dynamic> json) =>
    ConversationsRequest(
      assistandId: json['assistandId'] as String,
      assistantModel: json['assistantModel'] as String,
      cursor: json['cursor'] as String?,
    );

Map<String, dynamic> _$ConversationsRequestToJson(
        ConversationsRequest instance) =>
    <String, dynamic>{
      'assistandId': instance.assistandId,
      'assistantModel': instance.assistantModel,
      'cursor': instance.cursor,
    };
