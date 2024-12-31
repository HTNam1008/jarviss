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

KnowledgeResponse _$KnowledgeResponseFromJson(Map<String, dynamic> json) =>
    KnowledgeResponse(
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      createdBy: json['createdBy'] as String,
      updatedBy: json['updatedBy'] as String,
      userId: json['userId'] as String,
      knowledgeName: json['knowledgeName'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$KnowledgeResponseToJson(KnowledgeResponse instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
      'userId': instance.userId,
      'knowledgeName': instance.knowledgeName,
      'description': instance.description,
    };

UnitResponse _$UnitResponseFromJson(Map<String, dynamic> json) => UnitResponse(
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String?,
      createdBy: json['createdBy'] as String?,
      updatedBy: json['updatedBy'] as String?,
      id: json['id'] as String,
      name: json['name'] as String,
      status: json['status'] as bool,
      userId: json['userId'] as String,
      knowledgeId: json['knowledgeId'] as String,
    );

Map<String, dynamic> _$UnitResponseToJson(UnitResponse instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'userId': instance.userId,
      'knowledgeId': instance.knowledgeId,
    };
