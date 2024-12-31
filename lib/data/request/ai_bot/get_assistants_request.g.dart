// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_assistants_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAssistantsRequest _$GetAssistantsRequestFromJson(
        Map<String, dynamic> json) =>
    GetAssistantsRequest(
      isFavorite: json['isFavorite'] as bool?,
      isPublished: json['isPublished'] as bool?,
      limit: (json['limit'] as num?)?.toDouble(),
      offset: (json['offset'] as num?)?.toDouble(),
      order: $enumDecodeNullable(_$EnumOrderEnumMap, json['order']),
      orderField: json['orderField'] as String?,
      q: json['q'] as String?,
    );

Map<String, dynamic> _$GetAssistantsRequestToJson(
        GetAssistantsRequest instance) =>
    <String, dynamic>{
      'isFavorite': instance.isFavorite,
      'isPublished': instance.isPublished,
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
