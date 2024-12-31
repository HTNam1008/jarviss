// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'disconnect_bot_integration_request.g.dart';

@JsonSerializable()
class DisconnectBotIntegrationRequest {
    final String assistantId;
    final String type;

  DisconnectBotIntegrationRequest({
    required this.assistantId,
    required this.type,
  });

  factory DisconnectBotIntegrationRequest.fromJson(Map<String, dynamic> json) =>
      _$DisconnectBotIntegrationRequestFromJson(json);
  Map<String, dynamic> toJson() => _$DisconnectBotIntegrationRequestToJson(this);
}
