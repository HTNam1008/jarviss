// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:jarvis/data/responses/authentication_kb/knowledge_auth_response.dart';

part 'get_assistants_response.g.dart';

@JsonSerializable()
class GetAssistantsResponse {
  final List<AssistantData> data;
  final MetaData meta;

  GetAssistantsResponse({required this.data, required this.meta});

  factory GetAssistantsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAssistantsResponseFromJson(json);
}

@JsonSerializable()
class AssistantData {
  final String createdAt;
  final String? updatedAt;
  final String? createdBy;
  final String? updatedBy;
  final String? deletedAt;
  final String id;
  final String openAiAssistantId;
  final String? description;
  final String? instructions;
  final String assistantName;
  final String userId;
  final String? openAiVectorStoreId;
  final String? openAiThreadIdPlay;
  final bool? isDefault;
  final bool? isFavorite;
  
  AssistantData({
    required this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.deletedAt,
    required this.id,
    required this.openAiAssistantId,
    this.description,
    this.instructions,
    required this.assistantName,
    required this.userId,
    this.openAiVectorStoreId,
    this.openAiThreadIdPlay,
    this.isDefault,
    this.isFavorite,
  });



  factory AssistantData.fromJson(Map<String, dynamic> json) =>
      _$AssistantDataFromJson(json);
}

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
class GetUnitsResponse {
  final List<UnitData> data;
  final MetaData meta;

  GetUnitsResponse({
    required this.data,
    required this.meta,
  });

  factory GetUnitsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetUnitsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetUnitsResponseToJson(this);
}

@JsonSerializable()
class KnowledgeData {
  @JsonKey(name: '0')
  final String index;
  final String? createdAt;
  final String? updatedAt;
  final String? createdBy;
  final String? updatedBy;
  final String? userId;
  final String id;
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
    required this.id,
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
      id: json['id'] as String,
    );
  }

  Map<String, dynamic> toJson() => _$KnowledgeDataToJson(this);
}

@JsonSerializable()
class UnitData {
  @JsonKey(name: '0')
  final String createdAt;
  final String? updatedAt;
  final String? createdBy;
  final String? updatedBy;
  final String id;
  final String name;
  final bool status;
  final String userId;
  final String type;
  final String knowledgeId;
  final int size;
  final Object metadata;


  UnitData({
    required this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    required this.id,
    required this.name,
    required this.status,
    required this.userId,
    required this.knowledgeId,
    required this.type,
    required this.size,
    required this.metadata,
  });

  factory UnitData.fromJson(Map<String, dynamic> json) {
    return UnitData(
      id: json['id'] as String,
      name: json['name'] as String,
      status: json['status'] as bool, // Nullable
      userId: json['userId'] as String, // Nullable
      createdBy: json['createdBy'] as String?, // Nullable
      updatedBy: json['updatedBy'] as String?, // Nullable
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String?,
      type: json['type'] as String,
      knowledgeId: json['knowledgeId'] as String,
      size: json['size'] as int,
      metadata: json['metadata'] as Object
    );
  }

  Map<String, dynamic> toJson() => _$UnitDataToJson(this);
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