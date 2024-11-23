// ignore_for_file: public_member_api_docs, sort_constructors_first
// lib/data/response/send_message_response.dart

import 'package:json_annotation/json_annotation.dart';

part 'get_conversations_response.g.dart';

@JsonSerializable()
class ConversationsResponse {
    final String? cursor;
    final bool has_more;
    int limit;
    final List<ItemConversation>? items;

  ConversationsResponse({
    this.cursor,
    required this.has_more,
    this.items,
    required this.limit,
  });
  
  factory ConversationsResponse.fromJson(Map<String, dynamic> json) =>
      _$ConversationsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationsResponseToJson(this);
}

@JsonSerializable()
class ItemConversation {
    final int? createdAt;
    final String? id;
    final String? title;

    ItemConversation({
        this.createdAt,
        this.id,
        this.title,
    });

  factory ItemConversation.fromJson(Map<String, dynamic> json) =>
        _$ItemConversationFromJson(json);
  Map<String, dynamic> toJson() => _$ItemConversationToJson(this);
}