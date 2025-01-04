// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_web_file_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
