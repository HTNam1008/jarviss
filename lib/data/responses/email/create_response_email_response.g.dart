// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_response_email_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateResponseEmailResponse _$CreateResponseEmailResponseFromJson(
        Map<String, dynamic> json) =>
    CreateResponseEmailResponse(
      email: json['email'] as String,
      remainingUsage: (json['remainingUsage'] as num).toInt(),
    );

Map<String, dynamic> _$CreateResponseEmailResponseToJson(
        CreateResponseEmailResponse instance) =>
    <String, dynamic>{
      'email': instance.email,
      'remainingUsage': instance.remainingUsage,
    };
