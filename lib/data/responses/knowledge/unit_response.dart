import 'package:json_annotation/json_annotation.dart';

part 'unit_response.g.dart';

@JsonSerializable()
class UnitResponse {
  final String createdAt;
  final String? updatedAt;
  final String? createdBy;
  final String? updatedBy;
  final String id;
  final String name;
  final bool status;
  final String userId;
  final String knowledgeId;

  UnitResponse({
    required this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    required this.id,
    required this.name,
    required this.status,
    required this.userId,
    required this.knowledgeId,
  });

  factory UnitResponse.fromJson(Map<String, dynamic> json) =>
      _$UnitResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UnitResponseToJson(this);
}