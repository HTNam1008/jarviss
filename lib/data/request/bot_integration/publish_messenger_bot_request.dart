// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'publish_messenger_bot_request.g.dart';

@JsonSerializable()
class PublishMessengerBotRequest {
    final String assistandId;
    final String appSecret;
    final String botToken;
    final String pageId;

  PublishMessengerBotRequest({
    required this.assistandId,
    required this.appSecret,
    required this.botToken,
    required this.pageId,
  });

  factory PublishMessengerBotRequest.fromJson(Map<String, dynamic> json) =>
      _$PublishMessengerBotRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PublishMessengerBotRequestToJson(this);
}
