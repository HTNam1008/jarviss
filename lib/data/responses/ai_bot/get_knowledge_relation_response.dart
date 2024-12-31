// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'get_knowledge_relation_response.g.dart';

@JsonSerializable()
class GetKnowledgeRelationResponse {
  final List<KnowledgeRelation> data;
  final Meta meta;

  GetKnowledgeRelationResponse({
    required this.data,
    required this.meta,
  });

  factory GetKnowledgeRelationResponse.fromJson(Map<String, dynamic> json) => _$GetKnowledgeRelationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetKnowledgeRelationResponseToJson(this);
}

@JsonSerializable()
class KnowledgeRelation {
  final String? createdAt;
  final String? updatedAt;
  final String? createdBy;
  final String? updatedBy;
  final String? deletedAt;
  final String id;
  final String knowledgeName;
  final String description;
  final String userId;
  final bool isImported;
  final int numUnits;
  final int totalSize;

  KnowledgeRelation({
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.deletedAt,
    required this.id,
    required this.knowledgeName,
    required this.description,
    required this.userId,
    required this.isImported,
    required this.numUnits,
    required this.totalSize,
  });

  factory KnowledgeRelation.fromJson(Map<String, dynamic> json) => _$KnowledgeRelationFromJson(json);
  Map<String, dynamic> toJson() => _$KnowledgeRelationToJson(this);
}

@JsonSerializable()
class Meta {
  final int limit;
  final int offset;
  final int total;
  final bool hasNext;

  Meta({
    required this.limit,
    required this.offset,
    required this.total,
    required this.hasNext,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
  Map<String, dynamic> toJson() => _$MetaToJson(this);
}
