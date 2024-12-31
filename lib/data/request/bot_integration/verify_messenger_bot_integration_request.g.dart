// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_messenger_bot_integration_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyMessengerBotIntegrationRequest
    _$VerifyMessengerBotIntegrationRequestFromJson(Map<String, dynamic> json) =>
        VerifyMessengerBotIntegrationRequest(
          appSecret: json['appSecret'] as String,
          botToken: json['botToken'] as String,
          pageId: json['pageId'] as String,
        );

Map<String, dynamic> _$VerifyMessengerBotIntegrationRequestToJson(
        VerifyMessengerBotIntegrationRequest instance) =>
    <String, dynamic>{
      'appSecret': instance.appSecret,
      'botToken': instance.botToken,
      'pageId': instance.pageId,
    };
