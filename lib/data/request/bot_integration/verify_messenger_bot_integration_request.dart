// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'verify_messenger_bot_integration_request.g.dart';

@JsonSerializable()
class VerifyMessengerBotIntegrationRequest {
    final String appSecret;
    final String botToken;
    final String pageId;

  VerifyMessengerBotIntegrationRequest({
    required this.appSecret,
    required this.botToken,
    required this.pageId,
  });

  factory VerifyMessengerBotIntegrationRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyMessengerBotIntegrationRequestFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyMessengerBotIntegrationRequestToJson(this);
}
