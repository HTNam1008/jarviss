// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retrieve_message_thread_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RetrieveMessageThreadRequest _$RetrieveMessageThreadRequestFromJson(
        Map<String, dynamic> json) =>
    RetrieveMessageThreadRequest(
      openAiThreadId: json['openAiThreadId'] as String,
    );

Map<String, dynamic> _$RetrieveMessageThreadRequestToJson(
        RetrieveMessageThreadRequest instance) =>
    <String, dynamic>{
      'openAiThreadId': instance.openAiThreadId,
    };
