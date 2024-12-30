// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'verify_slack_bot_integration_request.g.dart';

@JsonSerializable()
class VerifySlackBotIntegrationRequest {
    final String botToken;
    final String clientId;
    final String clientSecret;
    final String signingSecret;

  VerifySlackBotIntegrationRequest({
    required this.botToken,
    required this.clientId,
    required this.clientSecret,
    required this.signingSecret,
  });

  factory VerifySlackBotIntegrationRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifySlackBotIntegrationRequestFromJson(json);
  Map<String, dynamic> toJson() => _$VerifySlackBotIntegrationRequestToJson(this);
}
