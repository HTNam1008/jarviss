// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'verify_telegram_bot_integration_request.g.dart';

@JsonSerializable()
class VerifyTelegramBotIntegrationRequest {
    final String botToken;

  VerifyTelegramBotIntegrationRequest({
    required this.botToken,
  });

  factory VerifyTelegramBotIntegrationRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyTelegramBotIntegrationRequestFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyTelegramBotIntegrationRequestToJson(this);
}
