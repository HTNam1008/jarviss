// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'import_knowledge_request.g.dart';

@JsonSerializable()
class ImportKnowledgeRequest {
  final String assistandId;
  final String knowledgeId;

  factory ImportKnowledgeRequest.fromJson(Map<String, dynamic> json) =>
      _$ImportKnowledgeRequestFromJson(json);

  ImportKnowledgeRequest({
    required this.assistandId,
    required this.knowledgeId,
  });

  Map<String, dynamic> toJson() => _$ImportKnowledgeRequestToJson(this);
}
