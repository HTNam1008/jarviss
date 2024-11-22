import 'package:jarvis/app/extensions.dart';
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
    return Message(conversationId: conversationId, message: message, remainingUsage: remainingUsage, isUser: isUser);
  }
}

extension TokenUsageResponseMapper on TokenUsageResponse {
  TokenUsage toDomain() {
    return TokenUsage(availaleTokens: availableTokens, totalToken: totalTokens, unlimited: unlimited, date: date);
  }
}
