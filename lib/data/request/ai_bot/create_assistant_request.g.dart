// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_assistant_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAssistantRequest _$CreateAssistantRequestFromJson(
        Map<String, dynamic> json) =>
    CreateAssistantRequest(
      assistantName: json['assistantName'] as String,
      description: json['description'] as String?,
      instructions: json['instructions'] as String?,
    );

Map<String, dynamic> _$CreateAssistantRequestToJson(
        CreateAssistantRequest instance) =>
    <String, dynamic>{
      'assistantName': instance.assistantName,
      'description': instance.description,
      'instructions': instance.instructions,
    };
