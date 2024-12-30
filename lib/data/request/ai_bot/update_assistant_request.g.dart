// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_assistant_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateAssistantRequest _$UpdateAssistantRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateAssistantRequest(
      assistantId: json['assistantId'] as String,
      assistantName: json['assistantName'] as String,
      description: json['description'] as String?,
      instructions: json['instructions'] as String?,
    );

Map<String, dynamic> _$UpdateAssistantRequestToJson(
        UpdateAssistantRequest instance) =>
    <String, dynamic>{
      'assistantId': instance.assistantId,
      'assistantName': instance.assistantName,
      'description': instance.description,
      'instructions': instance.instructions,
    };
