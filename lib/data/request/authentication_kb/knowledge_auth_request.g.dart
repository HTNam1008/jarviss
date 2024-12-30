// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'knowledge_auth_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KnowledgeAuthRequest _$KnowledgeAuthRequestFromJson(
        Map<String, dynamic> json) =>
    KnowledgeAuthRequest(
      token: json['token'] as String,
    );

Map<String, dynamic> _$KnowledgeAuthRequestToJson(
        KnowledgeAuthRequest instance) =>
    <String, dynamic>{
      'token': instance.token,
    };

CreateKnowledgeRequest _$CreateKnowledgeRequestFromJson(
        Map<String, dynamic> json) =>
    CreateKnowledgeRequest(
      knowledgeName: json['knowledgeName'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$CreateKnowledgeRequestToJson(
        CreateKnowledgeRequest instance) =>
    <String, dynamic>{
      'knowledgeName': instance.knowledgeName,
      'description': instance.description,
    };

UploadLocalFileRequest _$UploadLocalFileRequestFromJson(
        Map<String, dynamic> json) =>
    UploadLocalFileRequest(
      file: UploadLocalFileRequest._fileFromJson(json['file'] as String?),
    );

Map<String, dynamic> _$UploadLocalFileRequestToJson(
        UploadLocalFileRequest instance) =>
    <String, dynamic>{
      'file': UploadLocalFileRequest._fileToJson(instance.file),
    };

UploadSlackFileRequest _$UploadSlackFileRequestFromJson(
        Map<String, dynamic> json) =>
    UploadSlackFileRequest(
      unitName: json['unitName'] as String,
      slackWorkspace: json['slackWorkspace'] as String,
      slackBotToken: json['slackBotToken'] as String,
    );

Map<String, dynamic> _$UploadSlackFileRequestToJson(
        UploadSlackFileRequest instance) =>
    <String, dynamic>{
      'unitName': instance.unitName,
      'slackWorkspace': instance.slackWorkspace,
      'slackBotToken': instance.slackBotToken,
    };

UploadWebFileRequest _$UploadWebFileRequestFromJson(
        Map<String, dynamic> json) =>
    UploadWebFileRequest(
      unitName: json['unitName'] as String,
      webUrl: json['webUrl'] as String,
    );

Map<String, dynamic> _$UploadWebFileRequestToJson(
        UploadWebFileRequest instance) =>
    <String, dynamic>{
      'unitName': instance.unitName,
      'webUrl': instance.webUrl,
    };

UploadConfluenceFileRequest _$UploadConfluenceFileRequestFromJson(
        Map<String, dynamic> json) =>
    UploadConfluenceFileRequest(
      unitName: json['unitName'] as String,
      wikiPageUrl: json['wikiPageUrl'] as String,
      confluenceUsername: json['confluenceUsername'] as String,
      confluenceAccessToken: json['confluenceAccessToken'] as String,
    );

Map<String, dynamic> _$UploadConfluenceFileRequestToJson(
        UploadConfluenceFileRequest instance) =>
    <String, dynamic>{
      'unitName': instance.unitName,
      'wikiPageUrl': instance.wikiPageUrl,
      'confluenceUsername': instance.confluenceUsername,
      'confluenceAccessToken': instance.confluenceAccessToken,
    };
