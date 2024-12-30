// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'publish_telegram_bot_request.g.dart';

@JsonSerializable()
class PublishTelegramBotRequest {
    final String assistandId;
    final String botToken;

  PublishTelegramBotRequest({
    required this.assistandId,
    required this.botToken,
  });

  factory PublishTelegramBotRequest.fromJson(Map<String, dynamic> json) =>
      _$PublishTelegramBotRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PublishTelegramBotRequestToJson(this);
}
