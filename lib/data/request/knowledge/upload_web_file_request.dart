import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'upload_web_file_request.g.dart';

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