// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_units_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
