class Constant {
  static const String baseUrl = "https://api.jarvis.cx";
  static const String baseKnowledgeUrl = "https://knowledge-api.jarvis.cx";

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
  static const tokenUsage = '/api/v1/tokens/usage';
  static const getConversations = '/api/v1/ai-chat/conversations';

  // knowledge base
  static const createAssistant = '/kb-core/v1/ai-assistant';
  static const updateAssistant = '/kb-core/v1/ai-assistant/{${ConstantPath.assistantId}}';
  static const updateAssistantNewThreadPlayGround = '/kb-core/v1/ai-assistant/thread/playground';
  static const deleteAssistant = '/kb-core/v1/ai-assistant/{${ConstantPath.assistantId}}';
  static const getAssistant = "/kb-core/v1/ai-assistant/{${ConstantPath.assistantId}}";
  static const askAssistant = "/kb-core/v1/ai-assistant/{${ConstantPath.assistantId}}/ask";
  static const getAssistants = '/kb-core/v1/ai-assistant';
  static const retrieveMessageThread = '/kb-core/v1/ai-assistant/thread/{${ConstantPath.openAiThreadId}}/messages';
  static const signInKnowledgeBase = '/kb-core/v1/auth/external-sign-in';
  static const createThread = '/kb-core/v1/ai-assistant/thread';
  static const importKnowledgeToAssistant = '/kb-core/v1/ai-assistant/{${ConstantPath.assistantId}}/knowledges/{${ConstantPath.knowledgeId}}';
  static const removeKnowledgeFromAssistant = '/kb-core/v1/ai-assistant/{${ConstantPath.assistantId}}/knowledges/{${ConstantPath.knowledgeId}}';
  static const getImportedKnowledge = '/kb-core/v1/ai-assistant/{${ConstantPath.assistantId}}/knowledges';

  // bot integration
  static const publishMessengerBot = '/kb-core/v1/bot-integration/messenger/publish/{${ConstantPath.assistantId}}';
  static const publishSlackBot = '/kb-core/v1/bot-integration/slack/publish/{${ConstantPath.assistantId}}';
  static const publishTelegramBot = '/kb-core/v1/bot-integration/telegram/publish/{${ConstantPath.assistantId}}';
  static const getConfigurations = '/kb-core/v1/bot-integration/{${ConstantPath.assistantId}}/configurations';
  static const disconnectBotIntegration = '/kb-core/v1/bot-integration/{${ConstantPath.assistantId}}/{${ConstantPath.type}}';
  static const verifyTelegramBotConfigure = '/kb-core/v1/bot-integration/telegram/validation';
  static const verifySlackBotConfigure = '/kb-core/v1/bot-integration/slack/validation';
  static const verifyMessengerBotConfigure = '/kb-core/v1/bot-integration/messenger/validation';
}

class ConstantAssistantID {
    static const String CLAUDE_3_HAIKU_20240307 = 'Claude 3 Haiku';
    static const String CLAUDE_35_SONNET_20240229 = 'Claude 3.5 Sonnet';
    static const String GEMINI_15_FLASH_LATEST = "Gemini 1.5 Flash";
    static const String GEMINI_15_PRO_LATEST = "Gemini 1.5 Pro";
    static const String GPT_4_O = "GPT-4o";
    static const String GPT_4_O_MINI = "GPT-4o Mini";
}

class ConstantAssistantModel {
  static const String DIFY = "dify";
}

class ConstantPath {
  static const String assistantId = "assistantId";
  static const String openAiThreadId = "openAiThreadId";
  static const String type = "type";
  static const String knowledgeId = "knowledgeId";
}

enum EnumOrder {
  ASC,
  DESC
}

enum PlatformType {
  slack,
  telegram,
  messenger
}