import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'upload_slack_file_request.g.dart';

@JsonSerializable()
class UploadSlackFileRequest{
  final String unitName;
  final String slackWorkspace;
  final String slackBotToken;

  UploadSlackFileRequest({
    required this.unitName,
    required this.slackWorkspace,
    required this.slackBotToken,
  });

  factory UploadSlackFileRequest.fromJson(Map<String, dynamic> json) =>
      _$UploadSlackFileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UploadSlackFileRequestToJson(this);
}