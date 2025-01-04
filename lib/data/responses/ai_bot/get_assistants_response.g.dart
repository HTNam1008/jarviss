// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_assistants_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAssistantsResponse _$GetAssistantsResponseFromJson(
        Map<String, dynamic> json) =>
    GetAssistantsResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => AssistantData.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: MetaData.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetAssistantsResponseToJson(
        GetAssistantsResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
    };

AssistantData _$AssistantDataFromJson(Map<String, dynamic> json) =>
    AssistantData(
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String?,
      createdBy: json['createdBy'] as String?,
      updatedBy: json['updatedBy'] as String?,
      deletedAt: json['deletedAt'] as String?,
      id: json['id'] as String,
      openAiAssistantId: json['openAiAssistantId'] as String,
      description: json['description'] as String?,
      instructions: json['instructions'] as String?,
      assistantName: json['assistantName'] as String,
      userId: json['userId'] as String,
      openAiVectorStoreId: json['openAiVectorStoreId'] as String?,
      openAiThreadIdPlay: json['openAiThreadIdPlay'] as String?,
      isDefault: json['isDefault'] as bool?,
      isFavorite: json['isFavorite'] as bool?,
    );

Map<String, dynamic> _$AssistantDataToJson(AssistantData instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
      'deletedAt': instance.deletedAt,
      'id': instance.id,
      'openAiAssistantId': instance.openAiAssistantId,
      'description': instance.description,
      'instructions': instance.instructions,
      'assistantName': instance.assistantName,
      'userId': instance.userId,
      'openAiVectorStoreId': instance.openAiVectorStoreId,
      'openAiThreadIdPlay': instance.openAiThreadIdPlay,
      'isDefault': instance.isDefault,
      'isFavorite': instance.isFavorite,
    };

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

GetUnitsResponse _$GetUnitsResponseFromJson(Map<String, dynamic> json) =>
    GetUnitsResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => UnitData.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: MetaData.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetUnitsResponseToJson(GetUnitsResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
    };

KnowledgeData _$KnowledgeDataFromJson(Map<String, dynamic> json) =>
    KnowledgeData(
      index: json['0'] as String,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      createdBy: json['createdBy'] as String?,
      updatedBy: json['updatedBy'] as String?,
      userId: json['userId'] as String?,
      id: json['id'] as String,
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
      'id': instance.id,
      'knowledgeName': instance.knowledgeName,
      'description': instance.description,
      'numUnits': instance.numUnits,
      'totalSize': instance.totalSize,
    };

UnitData _$UnitDataFromJson(Map<String, dynamic> json) => UnitData(
      createdAt: json['0'] as String,
      updatedAt: json['updatedAt'] as String?,
      createdBy: json['createdBy'] as String?,
      updatedBy: json['updatedBy'] as String?,
      id: json['id'] as String,
      name: json['name'] as String,
      status: json['status'] as bool,
      userId: json['userId'] as String,
      knowledgeId: json['knowledgeId'] as String,
      type: json['type'] as String,
      size: (json['size'] as num).toInt(),
      metadata: json['metadata'] as Object,
    );

Map<String, dynamic> _$UnitDataToJson(UnitData instance) => <String, dynamic>{
      '0': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'userId': instance.userId,
      'type': instance.type,
      'knowledgeId': instance.knowledgeId,
      'size': instance.size,
      'metadata': instance.metadata,
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
