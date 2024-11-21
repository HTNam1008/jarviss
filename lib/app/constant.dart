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