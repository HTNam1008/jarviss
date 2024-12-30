// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_assistant_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAssistantResponse _$GetAssistantResponseFromJson(
        Map<String, dynamic> json) =>
    GetAssistantResponse(
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
      userId: json['userId'] as String?,
      openAiVectorStoreId: json['openAiVectorStoreId'] as String?,
      openAiThreadIdPlay: json['openAiThreadIdPlay'] as String?,
      isDefault: json['isDefault'] as bool?,
      isFavorite: json['isFavorite'] as bool?,
    );

Map<String, dynamic> _$GetAssistantResponseToJson(
        GetAssistantResponse instance) =>
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
