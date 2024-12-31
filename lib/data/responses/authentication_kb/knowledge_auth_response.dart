import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';
import 'package:jarvis/data/responses/responses.dart';

part 'knowledge_auth_response.g.dart';

@JsonSerializable()
class KnowledgeAuthResponse {
  final TokenResponse token;

  KnowledgeAuthResponse({required this.token});

  factory KnowledgeAuthResponse.fromJson(Map<String, dynamic> json) =>
      _$KnowledgeAuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$KnowledgeAuthResponseToJson(this);
}

@JsonSerializable()
class KnowledgeResponse {
  final String createdAt;
  final String updatedAt;
  final String createdBy;
  final String updatedBy;
  final String userId;
  final String knowledgeName;
  final String? description;

  KnowledgeResponse({
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.userId,
    required this.knowledgeName,
    this.description,
  });

  factory KnowledgeResponse.fromJson(Map<String, dynamic> json) =>
      _$KnowledgeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$KnowledgeResponseToJson(this);
}

@JsonSerializable()
class UnitResponse {
  final String createdAt;
  final String? updatedAt;
  final String? createdBy;
  final String? updatedBy;
  final String id;
  final String name;
  final bool status;
  final String userId;
  final String knowledgeId;

  UnitResponse({
    required this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    required this.id,
    required this.name,
    required this.status,
    required this.userId,
    required this.knowledgeId,
  });

  factory UnitResponse.fromJson(Map<String, dynamic> json) =>
      _$UnitResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UnitResponseToJson(this);
}