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

class Message {
  final String conversationId;
  final String message;
  final int remainingUsage;
  final bool isUser;
  final DateTime timestamp = DateTime.now();

  Message({
    required this.conversationId,
    required this.message,
    required this.remainingUsage,
    required this.isUser,
  });

  Message copyWith({
    String? conversationId,
    String? message,
    int? remainingUsage,
    bool? isUser,
  }) {
    return Message(
      conversationId: conversationId ?? this.conversationId,
      message: message ?? this.message,
      remainingUsage: remainingUsage ?? this.remainingUsage,
      isUser: isUser ?? this.isUser,
    );
  }
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

