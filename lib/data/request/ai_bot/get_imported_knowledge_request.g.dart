// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_imported_knowledge_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetImportedKnowledgeRequest _$GetImportedKnowledgeRequestFromJson(
        Map<String, dynamic> json) =>
    GetImportedKnowledgeRequest(
      assistandId: json['assistandId'] as String,
      limit: (json['limit'] as num?)?.toDouble(),
      offset: (json['offset'] as num?)?.toDouble(),
      order: $enumDecodeNullable(_$EnumOrderEnumMap, json['order']),
      orderField: json['orderField'] as String?,
      q: json['q'] as String?,
    );

Map<String, dynamic> _$GetImportedKnowledgeRequestToJson(
        GetImportedKnowledgeRequest instance) =>
    <String, dynamic>{
      'assistandId': instance.assistandId,
      'limit': instance.limit,
      'offset': instance.offset,
      'order': _$EnumOrderEnumMap[instance.order],
      'orderField': instance.orderField,
      'q': instance.q,
    };

const _$EnumOrderEnumMap = {
  EnumOrder.ASC: 'ASC',
  EnumOrder.DESC: 'DESC',
};
