// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'knowledge_auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KnowledgeAuthResponse _$KnowledgeAuthResponseFromJson(
        Map<String, dynamic> json) =>
    KnowledgeAuthResponse(
      token: TokenResponse.fromJson(json['token'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$KnowledgeAuthResponseToJson(
        KnowledgeAuthResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
    };
