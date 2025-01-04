// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_knowledge_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateKnowledgeRequest _$CreateKnowledgeRequestFromJson(
        Map<String, dynamic> json) =>
    CreateKnowledgeRequest(
      knowledgeName: json['knowledgeName'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$CreateKnowledgeRequestToJson(
        CreateKnowledgeRequest instance) =>
    <String, dynamic>{
      'knowledgeName': instance.knowledgeName,
      'description': instance.description,
    };
