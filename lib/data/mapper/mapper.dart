import 'package:jarvis/app/extensions.dart';
import 'package:jarvis/data/request/ai_chat/send_message/assistant.dart';
import 'package:jarvis/data/request/ai_chat/send_message/chat_message.dart';
import 'package:jarvis/data/request/ai_chat/send_message/message_role.dart';
import 'package:jarvis/data/responses/ai_chat/get_conversation_history_response.dart';
import 'package:jarvis/data/responses/ai_chat/get_conversations_response.dart';
import 'package:jarvis/data/responses/ai_chat/send_message_response.dart';
import 'package:jarvis/data/responses/responses.dart';
import 'package:jarvis/data/responses/token/token_usage_response.dart';
import 'package:jarvis/domain/model/model.dart';

const EMPTY = "";
const ZERO = 0;

extension UserResponseMapper on UserResponse {
  User toDomain() {
    return User(
      id: id.orEmpty(),
      email: email.orEmpty(),
      username: username.orEmpty(),
      isActive: isActive,
      roles: roles,
      createdAt: createdAt.orEmpty(),
      updatedAt: updatedAt.orEmpty(),
    );
  }
}

extension TokenResponseMapper on TokenResponse {
  Token toDomain() {
    return Token(
      accessToken: accessToken.orEmpty(),
      refreshToken: refreshToken.orEmpty(),
    );
  }
}

extension SignInResponseMapper on SignInResponse {
  Token toDomain() {
    return token.toDomain();
  }
}

extension SignUpResponseMapper on SignUpResponse {
  User toDomain() {
    return user.toDomain();
  }
}

extension RefreshTokenResponseMapper on RefreshTokenResponse {
  Token toDomain() {
    return token.toDomain();
  }
}

// extension MessageResponseMapper on MessageResponse {
//   Message toDomain(bool isUser) {
//     return Message(conversationId: conversationId, message: message, remainingUsage: remainingUsage, isUser: isUser);
//   }
// }

extension SendMessageResponseMapper on SendMessageResponse {
  Message toDomain({bool isUser = false}) {
    return Message(conversationId: conversationId, message: message, remainingUsage: remainingUsage, isUser: isUser, timestamp: DateTime.now());
  }
}

extension TokenUsageResponseMapper on TokenUsageResponse {
  TokenUsage toDomain() {
    return TokenUsage(availaleTokens: availableTokens, totalToken: totalTokens, unlimited: unlimited, date: date);
  }
}

extension ConversationsResponseMapper on ConversationsResponse {
  Conversations toDomain() {
    return Conversations(cursor: cursor, has_more: has_more, limit: limit, items: items);
  }
}

extension ConversationHistoryMapper on ConversationHistoryResponse {
  ConversationHistory toDomain() {
    List<Message> messages = [];
    Assistant assistant = Assistant(model: 'dify', name: 'GPT-4o', id: 'gpt-4o');

    for (var detail in items) {
      // Nếu có query từ người dùng
      if (detail.query != null && detail.query!.isNotEmpty) {
        Message userMessage = Message(
          conversationId: detail.id ?? '',
          message: detail.query!,
          remainingUsage: 0,
          isUser: true,
          assistant: assistant,
          timestamp: detail.createdAt != null
              ? DateTime.fromMillisecondsSinceEpoch(detail.createdAt! * 1000)
              : DateTime.now(),
        );
        messages.add(userMessage);
      }

      // Nếu có answer từ trợ lý
      if (detail.answer != null && detail.answer!.isNotEmpty) {
        Message assistantMessage = Message(
          conversationId: detail.id ?? '',
          message: detail.answer!,
          remainingUsage: 0, 
          isUser: false,
          timestamp: detail.createdAt != null
              ? DateTime.fromMillisecondsSinceEpoch(detail.createdAt! * 1000)
              : DateTime.now(),
          assistant: assistant,
        );
        messages.add(assistantMessage);
      }
    }

    return ConversationHistory(has_more: has_more, limit: limit, cursor: cursor, items: messages);
  }
}

