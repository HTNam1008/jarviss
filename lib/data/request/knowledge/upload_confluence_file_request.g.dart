// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_confluence_file_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
