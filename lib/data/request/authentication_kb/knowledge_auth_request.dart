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

