// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publish_slack_bot_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublishSlackBotRequest _$PublishSlackBotRequestFromJson(
        Map<String, dynamic> json) =>
    PublishSlackBotRequest(
      assistandId: json['assistandId'] as String,
      botToken: json['botToken'] as String,
      clientId: json['clientId'] as String,
      clientSecret: json['clientSecret'] as String,
      signingSecret: json['signingSecret'] as String,
    );

Map<String, dynamic> _$PublishSlackBotRequestToJson(
        PublishSlackBotRequest instance) =>
    <String, dynamic>{
      'assistandId': instance.assistandId,
      'botToken': instance.botToken,
      'clientId': instance.clientId,
      'clientSecret': instance.clientSecret,
      'signingSecret': instance.signingSecret,
    };
