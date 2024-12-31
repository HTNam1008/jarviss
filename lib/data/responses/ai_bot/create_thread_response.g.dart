// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_thread_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateThreadResponse _$CreateThreadResponseFromJson(
        Map<String, dynamic> json) =>
    CreateThreadResponse(
      threadName: json['threadName'] as String,
      assistantId: json['assistantId'] as String,
      createdAt: json['createdAt'] as String,
      createdBy: json['createdBy'] as String?,
      id: json['id'] as String,
      integratedPlatform: json['integratedPlatform'] as String?,
      openAiThreadId: json['openAiThreadId'] as String,
      updatedAt: json['updatedAt'] as String?,
      updatedBy: json['updatedBy'] as String?,
      deletedAt: json['deletedAt'] as String?,
    );

Map<String, dynamic> _$CreateThreadResponseToJson(
        CreateThreadResponse instance) =>
    <String, dynamic>{
      'threadName': instance.threadName,
      'assistantId': instance.assistantId,
      'createdAt': instance.createdAt,
      'createdBy': instance.createdBy,
      'id': instance.id,
      'integratedPlatform': instance.integratedPlatform,
      'openAiThreadId': instance.openAiThreadId,
      'updatedAt': instance.updatedAt,
      'updatedBy': instance.updatedBy,
      'deletedAt': instance.deletedAt,
    };
