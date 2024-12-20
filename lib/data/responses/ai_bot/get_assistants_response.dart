// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

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