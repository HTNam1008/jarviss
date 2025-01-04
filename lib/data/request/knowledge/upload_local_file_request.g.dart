// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_local_file_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
