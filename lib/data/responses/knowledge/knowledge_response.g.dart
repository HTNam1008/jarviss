// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'knowledge_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KnowledgeResponse _$KnowledgeResponseFromJson(Map<String, dynamic> json) =>
    KnowledgeResponse(
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      createdBy: json['createdBy'] as String,
      updatedBy: json['updatedBy'] as String,
      userId: json['userId'] as String,
      knowledgeName: json['knowledgeName'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$KnowledgeResponseToJson(KnowledgeResponse instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
      'userId': instance.userId,
      'knowledgeName': instance.knowledgeName,
      'description': instance.description,
    };
