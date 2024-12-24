// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'create_thread_response.g.dart';

@JsonSerializable()
class CreateThreadResponse {
    String threadName;
    String assistantId;
    String createdAt;
    String? createdBy;
    String id;
    String? integratedPlatform;
    String openAiThreadId;
    String? updatedAt;
    String? updatedBy;
    String? deletedAt;

  CreateThreadResponse({
    required this.threadName,
    required this.assistantId,
    required this.createdAt,
    this.createdBy,
    required this.id,
    this.integratedPlatform,
    required this.openAiThreadId,
    this.updatedAt,
    this.updatedBy,
    this.deletedAt,
  });

  factory CreateThreadResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateThreadResponseFromJson(json);
      
  Map<String, dynamic> toJson() => _$CreateThreadResponseToJson(this);
}
