import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'create_knowledge_request.g.dart';


@JsonSerializable()
class CreateKnowledgeRequest {
  final String knowledgeName;
  final String? description;

  CreateKnowledgeRequest({
    required this.knowledgeName,
    this.description
  });

  factory CreateKnowledgeRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateKnowledgeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateKnowledgeRequestToJson(this);
}