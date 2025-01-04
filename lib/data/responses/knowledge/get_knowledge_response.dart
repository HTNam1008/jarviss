import 'package:jarvis/data/responses/ai_bot/get_assistants_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_knowledge_response.g.dart';

@JsonSerializable()
class GetKnowledgeResponse {
  final List<KnowledgeData> data;
  final MetaData meta;

  GetKnowledgeResponse({
    required this.data,
    required this.meta,
  });

  factory GetKnowledgeResponse.fromJson(Map<String, dynamic> json) =>
      _$GetKnowledgeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetKnowledgeResponseToJson(this);
}

@JsonSerializable()
class MetaData {
  final double limit;
  final double offset;
  final int total;
  final bool hasNext;

  MetaData({
    required this.limit,
    required this.offset,
    required this.total,
    required this.hasNext,
  });

  factory MetaData.fromJson(Map<String, dynamic> json) =>
      _$MetaDataFromJson(json);
}
/* 
@JsonSerializable()
class KnowledgeData {
  @JsonKey(name: '0')
  final String index;
  final String? createdAt;
  final String? updatedAt;
  final String? createdBy;
  final String? updatedBy;
  final String? userId;
  final String knowledgeName;
  final String description;
  final int? numUnits;
  final int? totalSize;


  KnowledgeData({
    required this.index,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.userId,
    required this.knowledgeName,
    required this.description,
    this.numUnits,
    this.totalSize
  });

  factory KnowledgeData.fromJson(Map<String, dynamic> json) {
    return KnowledgeData(
      index: json['id'] as String,
      knowledgeName: json['knowledgeName'] as String,
      description: json['description'] as String, // Nullable
      userId: json['userId'] as String?, // Nullable
      createdBy: json['createdBy'] as String?, // Nullable
      updatedBy: json['updatedBy'] as String?, // Nullable
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      numUnits: json['numUnits'] as int?,
      totalSize: json['totalSize'] as int?,
    );
  }

  Map<String, dynamic> toJson() => _$KnowledgeDataToJson(this);
} */