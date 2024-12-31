// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ask_assistant_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AskAssistantRequest _$AskAssistantRequestFromJson(Map<String, dynamic> json) =>
    AskAssistantRequest(
      assistandId: json['assistandId'] as String,
      message: json['message'] as String,
      openAiThreadId: json['openAiThreadId'] as String,
      additionalInstruction: json['additionalInstruction'] as String,
    );

Map<String, dynamic> _$AskAssistantRequestToJson(
        AskAssistantRequest instance) =>
    <String, dynamic>{
      'assistandId': instance.assistandId,
      'message': instance.message,
      'openAiThreadId': instance.openAiThreadId,
      'additionalInstruction': instance.additionalInstruction,
    };
