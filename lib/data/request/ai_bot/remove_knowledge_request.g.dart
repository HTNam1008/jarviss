// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remove_knowledge_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoveKnowledgeRequest _$RemoveKnowledgeRequestFromJson(
        Map<String, dynamic> json) =>
    RemoveKnowledgeRequest(
      assistandId: json['assistandId'] as String,
      knowledgeId: json['knowledgeId'] as String,
    );

Map<String, dynamic> _$RemoveKnowledgeRequestToJson(
        RemoveKnowledgeRequest instance) =>
    <String, dynamic>{
      'assistandId': instance.assistandId,
      'knowledgeId': instance.knowledgeId,
    };
