// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publish_messenger_bot_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublishMessengerBotRequest _$PublishMessengerBotRequestFromJson(
        Map<String, dynamic> json) =>
    PublishMessengerBotRequest(
      assistandId: json['assistandId'] as String,
      appSecret: json['appSecret'] as String,
      botToken: json['botToken'] as String,
      pageId: json['pageId'] as String,
    );

Map<String, dynamic> _$PublishMessengerBotRequestToJson(
        PublishMessengerBotRequest instance) =>
    <String, dynamic>{
      'assistandId': instance.assistandId,
      'appSecret': instance.appSecret,
      'botToken': instance.botToken,
      'pageId': instance.pageId,
    };
