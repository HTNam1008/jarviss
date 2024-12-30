import 'package:json_annotation/json_annotation.dart';

part 'get_imported_knowledge_response.g.dart';

@JsonSerializable()
class GetImportedKnowledgeResponse {
  final List<ImportedKnowledge> data;
  final Meta meta;

  GetImportedKnowledgeResponse({
    required this.data,
    required this.meta,
  });

  factory GetImportedKnowledgeResponse.fromJson(Map<String, dynamic> json) => _$GetImportedKnowledgeResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetImportedKnowledgeResponseToJson(this);
}

@JsonSerializable()
class ImportedKnowledge {
  final String? createdAt;
  final String? updatedAt;
  final String? createdBy;
  final String? updatedBy;
  final String? deletedAt;
  final String id;
  final String knowledgeName;
  final String description;
  final String userId;
  final int numUnits;
  final int totalSize;

  ImportedKnowledge({
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.deletedAt,
    required this.id,
    required this.knowledgeName,
    required this.description,
    required this.userId,
    required this.numUnits,
    required this.totalSize,
  });

  factory ImportedKnowledge.fromJson(Map<String, dynamic> json) => _$ImportedKnowledgeFromJson(json);
  Map<String, dynamic> toJson() => _$ImportedKnowledgeToJson(this);
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
