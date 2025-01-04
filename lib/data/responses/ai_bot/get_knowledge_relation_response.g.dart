// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_knowledge_relation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetKnowledgeRelationResponse _$GetKnowledgeRelationResponseFromJson(
        Map<String, dynamic> json) =>
    GetKnowledgeRelationResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => KnowledgeRelation.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetKnowledgeRelationResponseToJson(
        GetKnowledgeRelationResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
    };

KnowledgeRelation _$KnowledgeRelationFromJson(Map<String, dynamic> json) =>
    KnowledgeRelation(
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      createdBy: json['createdBy'] as String?,
      updatedBy: json['updatedBy'] as String?,
      deletedAt: json['deletedAt'] as String?,
      id: json['id'] as String,
      knowledgeName: json['knowledgeName'] as String,
      description: json['description'] as String,
      userId: json['userId'] as String,
      isImported: json['isImported'] as bool,
      numUnits: (json['numUnits'] as num).toInt(),
      totalSize: (json['totalSize'] as num).toInt(),
    );

Map<String, dynamic> _$KnowledgeRelationToJson(KnowledgeRelation instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
      'deletedAt': instance.deletedAt,
      'id': instance.id,
      'knowledgeName': instance.knowledgeName,
      'description': instance.description,
      'userId': instance.userId,
      'isImported': instance.isImported,
      'numUnits': instance.numUnits,
      'totalSize': instance.totalSize,
    };

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
      limit: (json['limit'] as num).toInt(),
      offset: (json['offset'] as num).toInt(),
      total: (json['total'] as num).toInt(),
      hasNext: json['hasNext'] as bool,
    );

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
      'limit': instance.limit,
      'offset': instance.offset,
      'total': instance.total,
      'hasNext': instance.hasNext,
    };
