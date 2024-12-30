// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'remove_knowledge_request.g.dart';

@JsonSerializable()
class RemoveKnowledgeRequest {
  final String assistandId;
  final String knowledgeId;

  factory RemoveKnowledgeRequest.fromJson(Map<String, dynamic> json) =>
      _$RemoveKnowledgeRequestFromJson(json);

  RemoveKnowledgeRequest({
    required this.assistandId,
    required this.knowledgeId,
  });

  Map<String, dynamic> toJson() => _$RemoveKnowledgeRequestToJson(this);
}
