// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'get_knowledge_relation_request.g.dart';

@JsonSerializable()
class GetKnowledgeRelationRequest {
    final String assistandId;
    final double? limit;
    final double? offset;

  factory GetKnowledgeRelationRequest.fromJson(Map<String, dynamic> json) =>
      _$GetKnowledgeRelationRequestFromJson(json);

  GetKnowledgeRelationRequest({
    required this.assistandId,
    this.limit,
    this.offset,
  });

  Map<String, dynamic> toJson() => _$GetKnowledgeRelationRequestToJson(this);
}
