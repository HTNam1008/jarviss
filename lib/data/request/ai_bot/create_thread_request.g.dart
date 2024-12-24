// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_thread_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateThreadRequest _$CreateThreadRequestFromJson(Map<String, dynamic> json) =>
    CreateThreadRequest(
      assistantId: json['assistantId'] as String,
      firstMessage: json['firstMessage'] as String?,
    );

Map<String, dynamic> _$CreateThreadRequestToJson(
        CreateThreadRequest instance) =>
    <String, dynamic>{
      'assistantId': instance.assistantId,
      'firstMessage': instance.firstMessage,
    };
