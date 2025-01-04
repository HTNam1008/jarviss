// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_email_reply_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateEmailReplyResponse _$CreateEmailReplyResponseFromJson(
        Map<String, dynamic> json) =>
    CreateEmailReplyResponse(
      ideas: (json['ideas'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CreateEmailReplyResponseToJson(
        CreateEmailReplyResponse instance) =>
    <String, dynamic>{
      'ideas': instance.ideas,
    };
