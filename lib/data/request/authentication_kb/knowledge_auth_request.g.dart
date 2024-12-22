// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'knowledge_auth_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KnowledgeAuthRequest _$KnowledgeAuthRequestFromJson(
        Map<String, dynamic> json) =>
    KnowledgeAuthRequest(
      token: json['token'] as String,
    );

Map<String, dynamic> _$KnowledgeAuthRequestToJson(
        KnowledgeAuthRequest instance) =>
    <String, dynamic>{
      'token': instance.token,
    };

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
