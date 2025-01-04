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
