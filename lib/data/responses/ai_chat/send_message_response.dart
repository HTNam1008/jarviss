// ignore_for_file: public_member_api_docs, sort_constructors_first
// lib/data/response/send_message_response.dart

import 'package:json_annotation/json_annotation.dart';

part 'send_message_response.g.dart';


@JsonSerializable()
class SendMessageResponse {
  final String conversationId;
  final String message;
  final int remainingUsage;
  
  SendMessageResponse({
    required this.conversationId,
    required this.message,
    required this.remainingUsage,
  });

  factory SendMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$SendMessageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SendMessageResponseToJson(this);
}
