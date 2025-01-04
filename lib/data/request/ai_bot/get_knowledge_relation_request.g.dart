// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_knowledge_relation_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetKnowledgeRelationRequest _$GetKnowledgeRelationRequestFromJson(
        Map<String, dynamic> json) =>
    GetKnowledgeRelationRequest(
      assistandId: json['assistandId'] as String,
      limit: (json['limit'] as num?)?.toDouble(),
      offset: (json['offset'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$GetKnowledgeRelationRequestToJson(
        GetKnowledgeRelationRequest instance) =>
    <String, dynamic>{
      'assistandId': instance.assistandId,
      'limit': instance.limit,
      'offset': instance.offset,
    };
