// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'publish_slack_bot_request.g.dart';

@JsonSerializable()
class PublishSlackBotRequest {
    final String assistandId;
    final String botToken;
    final String clientId;
    final String clientSecret;
    final String signingSecret;

  PublishSlackBotRequest({
    required this.assistandId,
    required this.botToken,
    required this.clientId,
    required this.clientSecret,
    required this.signingSecret,
  });

  factory PublishSlackBotRequest.fromJson(Map<String, dynamic> json) =>
      _$PublishSlackBotRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PublishSlackBotRequestToJson(this);
}
