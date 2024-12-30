// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'get_configurations_request.g.dart';

@JsonSerializable()
class GetConfigurationsRequest {
    final String assistantId;

  GetConfigurationsRequest({
    required this.assistantId,
  });

  factory GetConfigurationsRequest.fromJson(Map<String, dynamic> json) =>
      _$GetConfigurationsRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GetConfigurationsRequestToJson(this);
}
