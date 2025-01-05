// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'publish_bot_response.g.dart';

@JsonSerializable()
class PublishBotResponse {
  final String redirect;

  PublishBotResponse({
    required this.redirect,
  });

  factory PublishBotResponse.fromJson(Map<String, dynamic> json) => _$PublishBotResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PublishBotResponseToJson(this);
}

