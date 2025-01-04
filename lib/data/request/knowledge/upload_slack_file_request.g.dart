// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_slack_file_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
