// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'get_configurations_response.g.dart';

@JsonSerializable()
class GetConfigurationsResponse {
  @JsonKey(defaultValue: [])
  final List<Configuration> configurations;

  GetConfigurationsResponse({required this.configurations});

  factory GetConfigurationsResponse.fromJson(List<dynamic> json) => 
    json.isEmpty 
      ? GetConfigurationsResponse(configurations: [])
      : GetConfigurationsResponse(
          configurations: json.map((e) => Configuration.fromJson(e)).toList(),
        );

  Map<String, dynamic> toJson() => _$GetConfigurationsResponseToJson(this);
}

@JsonSerializable()
class Configuration {
  final String? createdAt;
  final String? updatedAt;
  final String? createdBy;
  final String? updatedBy;
  final String? deletedAt;
  final String? id;
  final String? type;
  final String? accessToken;
  final dynamic metadata;
  final String? assistantId;

  Configuration({
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.deletedAt,
    this.id,
    this.type,
    this.accessToken,
    this.metadata,
    this.assistantId,
  });

  factory Configuration.fromJson(Map<String, dynamic> json) {
    dynamic metadata;
    switch (json['type']) {
      case 'slack':
        metadata = json['metadata'] != null 
          ? SlackMetadata.fromJson(json['metadata']) 
          : null;
        break;
      case 'telegram':
        metadata = json['metadata'] != null 
          ? TelegramMetadata.fromJson(json['metadata']) 
          : null;
        break;
      case 'messenger':
        metadata = json['metadata'] != null 
          ? MessengerMetadata.fromJson(json['metadata']) 
          : null;
        break;
      default:
        metadata = json['metadata'];
    }

    return Configuration(
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      deletedAt: json['deletedAt'],
      id: json['id'],
      type: json['type'],
      accessToken: json['accessToken'],
      metadata: metadata,
      assistantId: json['assistantId'],
    );
  }

  Map<String, dynamic> toJson() => _$ConfigurationToJson(this);
}

@JsonSerializable()
class SlackMetadata {
  final String botToken;
  final String clientId;
  final String redirect;
  final String clientSecret;
  final String signingSecret;

  SlackMetadata({
    required this.botToken,
    required this.clientId,
    required this.redirect,
    required this.clientSecret,
    required this.signingSecret,
  });

  factory SlackMetadata.fromJson(Map<String, dynamic> json) =>
      _$SlackMetadataFromJson(json);
  
  Map<String, dynamic> toJson() => _$SlackMetadataToJson(this);
}

@JsonSerializable()
class TelegramMetadata {
  final String botToken;

  TelegramMetadata({required this.botToken});

  factory TelegramMetadata.fromJson(Map<String, dynamic> json) =>
      _$TelegramMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$TelegramMetadataToJson(this);
}

@JsonSerializable()
class MessengerMetadata {
  final String botToken;
  final String pageId;
  final String appSecret;
  final String redirect;


  MessengerMetadata({
    required this.botToken,
    required this.pageId,
    required this.appSecret,
    required this.redirect,
  });

  factory MessengerMetadata.fromJson(Map<String, dynamic> json) =>
      _$MessengerMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$MessengerMetadataToJson(this);
}
