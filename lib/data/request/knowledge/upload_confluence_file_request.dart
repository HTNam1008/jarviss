import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'upload_confluence_file_request.g.dart';

@JsonSerializable()
class UploadConfluenceFileRequest{
  final String unitName;
  final String wikiPageUrl;
  final String confluenceUsername;
  final String confluenceAccessToken;

  UploadConfluenceFileRequest({
    required this.unitName,
    required this.wikiPageUrl,
    required this.confluenceUsername,
    required this.confluenceAccessToken,

  });

  factory UploadConfluenceFileRequest.fromJson(Map<String, dynamic> json) =>
      _$UploadConfluenceFileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UploadConfluenceFileRequestToJson(this);
}