// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:jarvis/data/request/ai_chat/send_message/assistant.dart';
import 'package:jarvis/data/request/ai_chat/send_message/chat_message.dart';
import 'package:jarvis/data/responses/ai_chat/get_conversations_response.dart';

class User {
  final String id;
  final String email;
  final String username;
  final bool isActive;
  final List<String> roles;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.email,
    required this.username,
    required this.isActive,
    required this.roles,
    required this.createdAt,
    required this.updatedAt,
  });
}

class Token {
  final String accessToken;
  final String? refreshToken;

  Token({
    required this.accessToken,
    this.refreshToken,
  });
}

class TokenUsage {
  final int availaleTokens;
  final int totalToken;
  final bool unlimited;
  final DateTime date;

  TokenUsage({
    required this.availaleTokens,
    required this.totalToken,
    required this.unlimited,
    required this.date,
  });
}

class Message {
  final String conversationId;
  final String message;
  final int remainingUsage;
  final bool isUser;
  final DateTime? timestamp;
  final Assistant? assistant;

  Message({
    required this.conversationId,
    required this.message,
    required this.remainingUsage,
    required this.isUser,
    this.timestamp,
    this.assistant,
  });

  Message copyWith({
    String? conversationId,
    String? message,
    int? remainingUsage,
    bool? isUser,
    DateTime? timestamp,
  }) {
    return Message(
      conversationId: conversationId ?? this.conversationId,
      message: message ?? this.message,
      remainingUsage: remainingUsage ?? this.remainingUsage,
      isUser: isUser ?? this.isUser,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}

class Conversations {
  final String? cursor;
  final bool has_more;
  final int limit;
  final List<ItemConversation>? items;

  Conversations({
    this.cursor,
    required this.has_more,
    required this.limit,
    this.items,
  });
}

class ConversationHistory {
  final String? cursor;
  final bool has_more;
  final int limit;
  final List<Message>? items;

  ConversationHistory({
    this.cursor,
    required this.has_more,
    required this.limit,
    this.items,
  });
}

enum PromptCategory {
  ALL,
  MARKETING,
  BUSINESS,
  SEO,
  WRITING,
  CODING,
  CAREER,
  CHATBOT,
  EDUCATION,
  FUN,
  PRODUCTIVITY,
  OTHER
}

class PromptCategoryItem {
  final PromptCategory? value;
  final String label;

  const PromptCategoryItem({this.value, required this.label});
}

