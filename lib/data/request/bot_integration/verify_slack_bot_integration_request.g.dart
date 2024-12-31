// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_slack_bot_integration_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifySlackBotIntegrationRequest _$VerifySlackBotIntegrationRequestFromJson(
        Map<String, dynamic> json) =>
    VerifySlackBotIntegrationRequest(
      botToken: json['botToken'] as String,
      clientId: json['clientId'] as String,
      clientSecret: json['clientSecret'] as String,
      signingSecret: json['signingSecret'] as String,
    );

Map<String, dynamic> _$VerifySlackBotIntegrationRequestToJson(
        VerifySlackBotIntegrationRequest instance) =>
    <String, dynamic>{
      'botToken': instance.botToken,
      'clientId': instance.clientId,
      'clientSecret': instance.clientSecret,
      'signingSecret': instance.signingSecret,
    };
