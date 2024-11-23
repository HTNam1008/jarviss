// ignore_for_file: public_member_api_docs, sort_constructors_first
// lib/data/response/send_message_response.dart

import 'package:json_annotation/json_annotation.dart';

part 'get_conversation_history_response.g.dart';

@JsonSerializable()
class ConversationHistoryResponse {
    final String cursor;
    final bool has_more;
    int limit;
    final List<ConversationDetails> items;

  ConversationHistoryResponse({
    required this.cursor,
    required this.has_more,
    required this.items,
    required this.limit,
  });
  
  factory ConversationHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$ConversationHistoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationHistoryResponseToJson(this);
}

@JsonSerializable()
class ConversationDetails {
    final int? createdAt;
    final String? id;
    final String? answer;
    final String? query;

    ConversationDetails({
        this.createdAt,
        this.id,
        this.answer,
        this.query,
    });

  factory ConversationDetails.fromJson(Map<String, dynamic> json) =>
        _$ConversationDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$ConversationDetailsToJson(this);
}