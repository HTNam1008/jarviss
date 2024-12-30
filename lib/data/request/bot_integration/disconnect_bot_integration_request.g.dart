// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disconnect_bot_integration_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DisconnectBotIntegrationRequest _$DisconnectBotIntegrationRequestFromJson(
        Map<String, dynamic> json) =>
    DisconnectBotIntegrationRequest(
      assistantId: json['assistantId'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$DisconnectBotIntegrationRequestToJson(
        DisconnectBotIntegrationRequest instance) =>
    <String, dynamic>{
      'assistantId': instance.assistantId,
      'type': instance.type,
    };
