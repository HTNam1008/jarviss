import 'package:jarvis/data/responses/authentication_kb/knowledge_auth_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_units_response.g.dart';

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