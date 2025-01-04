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
