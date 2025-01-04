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
