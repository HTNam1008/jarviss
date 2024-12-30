// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_configurations_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetConfigurationsResponse _$GetConfigurationsResponseFromJson(
        Map<String, dynamic> json) =>
    GetConfigurationsResponse(
      configurations: (json['configurations'] as List<dynamic>?)
              ?.map((e) => Configuration.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$GetConfigurationsResponseToJson(
        GetConfigurationsResponse instance) =>
    <String, dynamic>{
      'configurations': instance.configurations,
    };

Configuration _$ConfigurationFromJson(Map<String, dynamic> json) =>
    Configuration(
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      createdBy: json['createdBy'] as String?,
      updatedBy: json['updatedBy'] as String?,
      deletedAt: json['deletedAt'] as String?,
      id: json['id'] as String?,
      type: json['type'] as String?,
      accessToken: json['accessToken'] as String?,
      metadata: json['metadata'],
      assistantId: json['assistantId'] as String?,
    );

Map<String, dynamic> _$ConfigurationToJson(Configuration instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
      'deletedAt': instance.deletedAt,
      'id': instance.id,
      'type': instance.type,
      'accessToken': instance.accessToken,
      'metadata': instance.metadata,
      'assistantId': instance.assistantId,
    };

SlackMetadata _$SlackMetadataFromJson(Map<String, dynamic> json) =>
    SlackMetadata(
      botToken: json['botToken'] as String,
      clientId: json['clientId'] as String,
      redirect: json['redirect'] as String,
      clientSecret: json['clientSecret'] as String,
      signingSecret: json['signingSecret'] as String,
    );

Map<String, dynamic> _$SlackMetadataToJson(SlackMetadata instance) =>
    <String, dynamic>{
      'botToken': instance.botToken,
      'clientId': instance.clientId,
      'redirect': instance.redirect,
      'clientSecret': instance.clientSecret,
      'signingSecret': instance.signingSecret,
    };

TelegramMetadata _$TelegramMetadataFromJson(Map<String, dynamic> json) =>
    TelegramMetadata(
      botToken: json['botToken'] as String,
    );

Map<String, dynamic> _$TelegramMetadataToJson(TelegramMetadata instance) =>
    <String, dynamic>{
      'botToken': instance.botToken,
    };

MessengerMetadata _$MessengerMetadataFromJson(Map<String, dynamic> json) =>
    MessengerMetadata(
      botToken: json['botToken'] as String,
      pageId: json['pageId'] as String,
      appSecret: json['appSecret'] as String,
      redirect: json['redirect'] as String,
    );

Map<String, dynamic> _$MessengerMetadataToJson(MessengerMetadata instance) =>
    <String, dynamic>{
      'botToken': instance.botToken,
      'pageId': instance.pageId,
      'appSecret': instance.appSecret,
      'redirect': instance.redirect,
    };
