import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'upload_local_file_request.g.dart';

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