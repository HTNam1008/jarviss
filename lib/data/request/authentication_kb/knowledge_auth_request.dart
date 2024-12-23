import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'knowledge_auth_request.g.dart';

@JsonSerializable()
class KnowledgeAuthRequest {
  final String token;

  KnowledgeAuthRequest({required this.token});

  factory KnowledgeAuthRequest.fromJson(Map<String, dynamic> json) =>
      _$KnowledgeAuthRequestFromJson(json);

  Map<String, dynamic> toJson() => _$KnowledgeAuthRequestToJson(this);
}

@JsonSerializable()
class CreateKnowledgeRequest {
  final String knowledgeName;
  final String? description;

  CreateKnowledgeRequest({
    required this.knowledgeName,
    this.description
  });

  factory CreateKnowledgeRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateKnowledgeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateKnowledgeRequestToJson(this);
}

@JsonSerializable()
class UploadLocalFileRequest {
  @JsonKey(
    toJson: _fileToJson,
    fromJson: _fileFromJson,
  )
  final File? file;

  UploadLocalFileRequest({this.file});

  factory UploadLocalFileRequest.fromJson(Map<String, dynamic> json) =>
      _$UploadLocalFileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UploadLocalFileRequestToJson(this);

  // Custom toJson function for File
  static String? _fileToJson(File? file) {
    return file?.path; // Convert the file to its path
  }

  // Custom fromJson function for File
  static File? _fileFromJson(String? filePath) {
    return filePath != null ? File(filePath) : null; // Convert the path back to a File
  }
}

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

@JsonSerializable()
class UploadWebFileRequest{
  final String unitName;
  final String webUrl;

  UploadWebFileRequest({
    required this.unitName,
    required this.webUrl,
  });

  factory UploadWebFileRequest.fromJson(Map<String, dynamic> json) =>
      _$UploadWebFileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UploadWebFileRequestToJson(this);
}

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