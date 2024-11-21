class Constant {
  static const String baseUrl = "https://api.dev.jarvis.cx";
  static const String APPLICATION_JSON = "application/json";
  static const String CONTENT_TYPE = "content-type";
  static const String ACCEPT = "accept";
  static const String AUTHORIZATION = "authorization";
  static const String DEFAULT_LANGUAGE = "language";
}

class ConstantAPI {
  static const signIn = '/api/v1/auth/sign-in';
  static const signUp = '/api/v1/auth/sign-up';
  static const signOut = '/api/v1/auth/sign-out';
  static const refreshToken = '/api/v1/auth/refresh';
  static const sendMessage = '/api/v1/ai-chat/messages';
}

class ConstantAssistantID {
    static const String CLAUDE_3_HAIKU_20240307 = 'Claude 3 Haiku';
    static const String CLAUDE_3_SONNET_20240229 = 'Claude 3 Sonnet';
    static const String GEMINI_15_FLASH_LATEST = "Gemini 1.5 Flash";
    static const String GEMINI_15_PRO_LATEST = "Gemini 1.5 Pro";
    static const String GPT_4_O = "GPT-4o";
    static const String GPT_4_O_MINI = "GPT-4o Mini";
}

class ConstantAssistantModel {
  static const String DIFY = "Dify";
}