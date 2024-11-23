// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_conversations_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationsResponse _$ConversationsResponseFromJson(
        Map<String, dynamic> json) =>
    ConversationsResponse(
      cursor: json['cursor'] as String?,
      has_more: json['has_more'] as bool,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => ItemConversation.fromJson(e as Map<String, dynamic>))
          .toList(),
      limit: (json['limit'] as num).toInt(),
    );

Map<String, dynamic> _$ConversationsResponseToJson(
        ConversationsResponse instance) =>
    <String, dynamic>{
      'cursor': instance.cursor,
      'has_more': instance.has_more,
      'limit': instance.limit,
      'items': instance.items,
    };

ItemConversation _$ItemConversationFromJson(Map<String, dynamic> json) =>
    ItemConversation(
      createdAt: (json['createdAt'] as num?)?.toInt(),
      id: json['id'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$ItemConversationToJson(ItemConversation instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'id': instance.id,
      'title': instance.title,
    };
