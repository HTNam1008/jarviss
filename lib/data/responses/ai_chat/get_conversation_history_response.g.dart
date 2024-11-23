// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_conversation_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationHistoryResponse _$ConversationHistoryResponseFromJson(
        Map<String, dynamic> json) =>
    ConversationHistoryResponse(
      cursor: json['cursor'] as String,
      has_more: json['has_more'] as bool,
      items: (json['items'] as List<dynamic>)
          .map((e) => ConversationDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      limit: (json['limit'] as num).toInt(),
    );

Map<String, dynamic> _$ConversationHistoryResponseToJson(
        ConversationHistoryResponse instance) =>
    <String, dynamic>{
      'cursor': instance.cursor,
      'has_more': instance.has_more,
      'limit': instance.limit,
      'items': instance.items,
    };

ConversationDetails _$ConversationDetailsFromJson(Map<String, dynamic> json) =>
    ConversationDetails(
      createdAt: (json['createdAt'] as num?)?.toInt(),
      id: json['id'] as String?,
      answer: json['answer'] as String?,
      query: json['query'] as String?,
    );

Map<String, dynamic> _$ConversationDetailsToJson(
        ConversationDetails instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'id': instance.id,
      'answer': instance.answer,
      'query': instance.query,
    };
