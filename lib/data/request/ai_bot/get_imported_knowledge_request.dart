// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:jarvis/app/constant.dart';

part 'get_imported_knowledge_request.g.dart';

@JsonSerializable()
class GetImportedKnowledgeRequest {
    final String assistandId;
    final double? limit;
    final double? offset;
    final EnumOrder? order;
    final String? orderField;
    final String? q;

  factory GetImportedKnowledgeRequest.fromJson(Map<String, dynamic> json) =>
      _$GetImportedKnowledgeRequestFromJson(json);

  GetImportedKnowledgeRequest({
    required this.assistandId,
    this.limit,
    this.offset,
    this.order,
    this.orderField,
    this.q,
  });

  Map<String, dynamic> toJson() => _$GetImportedKnowledgeRequestToJson(this);
}
