import 'package:json_annotation/json_annotation.dart';

part 'token_usage_response.g.dart';

@JsonSerializable()
class TokenUsageResponse {
  final int availableTokens;
  final int totalTokens;
  final bool unlimited;
  final DateTime date;

  TokenUsageResponse({
    required this.availableTokens,
    required this.totalTokens,
    required this.unlimited,
    required this.date,
  });

  factory TokenUsageResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenUsageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TokenUsageResponseToJson(this);
}
