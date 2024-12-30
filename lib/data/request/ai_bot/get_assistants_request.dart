import 'package:json_annotation/json_annotation.dart';

import '../../../app/constant.dart';

part 'get_assistants_request.g.dart';

@JsonSerializable()
class GetAssistantsRequest {
  final bool? isFavorite;
  final bool? isPublished;
  final double? limit;
  final double? offset;
  final EnumOrder? order;
  final String? orderField;
  final String? q;

  factory GetAssistantsRequest.fromJson(Map<String, dynamic> json) =>
      _$GetAssistantsRequestFromJson(json);

  GetAssistantsRequest(
      {this.isFavorite,
      this.isPublished,
      this.limit,
      this.offset,
      this.order,
      this.orderField,
      this.q});

  Map<String, dynamic> toJson() => _$GetAssistantsRequestToJson(this);
}
