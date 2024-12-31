// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_assistant_new_thread_playground_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateAssistantNewThreadPlayGroundResponse
    _$UpdateAssistantNewThreadPlayGroundResponseFromJson(
            Map<String, dynamic> json) =>
        UpdateAssistantNewThreadPlayGroundResponse(
          assistantName: json['assistantName'] as String,
          createdAt: json['createdAt'] as String,
          deletedAt: json['deletedAt'] as String?,
          createdBy: json['createdBy'] as String?,
          description: json['description'] as String?,
          id: json['id'] as String,
          instructions: json['instructions'] as String?,
          isDefault: json['isDefault'] as bool,
          isFavorite: json['isFavorite'] as bool,
          openAiAssistantId: json['openAiAssistantId'] as String,
          openAiThreadIdPlay: json['openAiThreadIdPlay'] as String,
          openAiVectorStoreId: json['openAiVectorStoreId'] as String?,
          updatedAt: json['updatedAt'] as String?,
          updatedBy: json['updatedBy'] as String?,
          userId: json['userId'] as String?,
        );

Map<String, dynamic> _$UpdateAssistantNewThreadPlayGroundResponseToJson(
        UpdateAssistantNewThreadPlayGroundResponse instance) =>
    <String, dynamic>{
      'assistantName': instance.assistantName,
      'createdAt': instance.createdAt,
      'deletedAt': instance.deletedAt,
      'createdBy': instance.createdBy,
      'description': instance.description,
      'id': instance.id,
      'instructions': instance.instructions,
      'isDefault': instance.isDefault,
      'isFavorite': instance.isFavorite,
      'openAiAssistantId': instance.openAiAssistantId,
      'openAiThreadIdPlay': instance.openAiThreadIdPlay,
      'openAiVectorStoreId': instance.openAiVectorStoreId,
      'updatedAt': instance.updatedAt,
      'updatedBy': instance.updatedBy,
      'userId': instance.userId,
    };
