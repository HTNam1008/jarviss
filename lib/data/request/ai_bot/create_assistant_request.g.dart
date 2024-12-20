// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_assistant_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAssistantResponse _$CreateAssistantResponseFromJson(
        Map<String, dynamic> json) =>
    CreateAssistantResponse(
      assistantName: json['assistantName'] as String,
      description: json['description'] as String?,
      instructions: json['instructions'] as String?,
    );

Map<String, dynamic> _$CreateAssistantResponseToJson(
        CreateAssistantResponse instance) =>
    <String, dynamic>{
      'assistantName': instance.assistantName,
      'description': instance.description,
      'instructions': instance.instructions,
    };
