// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publish_telegram_bot_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublishTelegramBotRequest _$PublishTelegramBotRequestFromJson(
        Map<String, dynamic> json) =>
    PublishTelegramBotRequest(
      assistandId: json['assistandId'] as String,
      botToken: json['botToken'] as String,
    );

Map<String, dynamic> _$PublishTelegramBotRequestToJson(
        PublishTelegramBotRequest instance) =>
    <String, dynamic>{
      'assistandId': instance.assistandId,
      'botToken': instance.botToken,
    };
