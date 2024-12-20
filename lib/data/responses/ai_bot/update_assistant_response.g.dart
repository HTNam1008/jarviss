// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_assistant_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateAssistantResponse _$UpdateAssistantResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateAssistantResponse(
      assistantName: json['assistantName'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      createdBy: json['createdBy'] as String?,
      description: json['description'] as String?,
      id: json['id'] as String,
      instructions: json['instructions'] as String?,
      openAiAssistantId: json['openAiAssistantId'] as String,
      openAiThreadIdPlay: json['openAiThreadIdPlay'] as String?,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      updatedBy: json['updatedBy'] as String?,
    );

Map<String, dynamic> _$UpdateAssistantResponseToJson(
        UpdateAssistantResponse instance) =>
    <String, dynamic>{
      'assistantName': instance.assistantName,
      'createdAt': instance.createdAt.toIso8601String(),
      'createdBy': instance.createdBy,
      'description': instance.description,
      'id': instance.id,
      'instructions': instance.instructions,
      'openAiAssistantId': instance.openAiAssistantId,
      'openAiThreadIdPlay': instance.openAiThreadIdPlay,
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'updatedBy': instance.updatedBy,
    };
