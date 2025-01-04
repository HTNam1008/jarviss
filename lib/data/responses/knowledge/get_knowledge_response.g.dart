// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_knowledge_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetKnowledgeResponse _$GetKnowledgeResponseFromJson(
        Map<String, dynamic> json) =>
    GetKnowledgeResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => KnowledgeData.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: MetaData.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetKnowledgeResponseToJson(
        GetKnowledgeResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
    };

MetaData _$MetaDataFromJson(Map<String, dynamic> json) => MetaData(
      limit: (json['limit'] as num).toDouble(),
      offset: (json['offset'] as num).toDouble(),
      total: (json['total'] as num).toInt(),
      hasNext: json['hasNext'] as bool,
    );

Map<String, dynamic> _$MetaDataToJson(MetaData instance) => <String, dynamic>{
      'limit': instance.limit,
      'offset': instance.offset,
      'total': instance.total,
      'hasNext': instance.hasNext,
    };

KnowledgeData _$KnowledgeDataFromJson(Map<String, dynamic> json) =>
    KnowledgeData(
      index: json['0'] as String,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      createdBy: json['createdBy'] as String?,
      updatedBy: json['updatedBy'] as String?,
      userId: json['userId'] as String?,
      knowledgeName: json['knowledgeName'] as String,
      description: json['description'] as String,
      numUnits: (json['numUnits'] as num?)?.toInt(),
      totalSize: (json['totalSize'] as num?)?.toInt(),
    );

Map<String, dynamic> _$KnowledgeDataToJson(KnowledgeData instance) =>
    <String, dynamic>{
      '0': instance.index,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
      'userId': instance.userId,
      'knowledgeName': instance.knowledgeName,
      'description': instance.description,
      'numUnits': instance.numUnits,
      'totalSize': instance.totalSize,
    };
