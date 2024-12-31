// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_assistant_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAssistantResponse _$CreateAssistantResponseFromJson(
        Map<String, dynamic> json) =>
    CreateAssistantResponse(
      assistantName: json['assistantName'] as String,
      createdAt: json['createdAt'] as String,
      createdBy: json['createdBy'] as String?,
      description: json['description'] as String?,
      id: json['id'] as String,
      instructions: json['instructions'] as String?,
      openAiAssistantId: json['openAiAssistantId'] as String,
      openAiThreadIdPlay: json['openAiThreadIdPlay'] as String?,
      updatedAt: json['updatedAt'] as String?,
      updatedBy: json['updatedBy'] as String?,
    );

Map<String, dynamic> _$CreateAssistantResponseToJson(
        CreateAssistantResponse instance) =>
    <String, dynamic>{
      'assistantName': instance.assistantName,
      'createdAt': instance.createdAt,
      'createdBy': instance.createdBy,
      'description': instance.description,
      'id': instance.id,
      'instructions': instance.instructions,
      'openAiAssistantId': instance.openAiAssistantId,
      'openAiThreadIdPlay': instance.openAiThreadIdPlay,
      'updatedAt': instance.updatedAt,
      'updatedBy': instance.updatedBy,
    };
