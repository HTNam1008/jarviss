// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_assistant_new_thread_playground_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateAssistantNewThreadPlayGroundRequest
    _$UpdateAssistantNewThreadPlayGroundRequestFromJson(
            Map<String, dynamic> json) =>
        UpdateAssistantNewThreadPlayGroundRequest(
          assistantId: json['assistantId'] as String,
          firstMessage: json['firstMessage'] as String? ?? '',
        );

Map<String, dynamic> _$UpdateAssistantNewThreadPlayGroundRequestToJson(
        UpdateAssistantNewThreadPlayGroundRequest instance) =>
    <String, dynamic>{
      'assistantId': instance.assistantId,
      'firstMessage': instance.firstMessage,
    };
