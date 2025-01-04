import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/ai_bot/ask_assistant_request.dart';
import 'package:jarvis/data/request/ai_bot/create_assistant_request.dart';
import 'package:jarvis/data/request/ai_bot/create_thread_request.dart';
import 'package:jarvis/data/request/ai_bot/delete_assistant_request.dart';
import 'package:jarvis/data/request/ai_bot/get_assistant_request.dart';
import 'package:jarvis/data/request/ai_bot/get_assistants_request.dart';
import 'package:jarvis/data/request/ai_bot/retrieve_message_thread_request.dart';
import 'package:jarvis/data/request/ai_bot/update_assistant_new_thread_playground_request.dart';
import 'package:jarvis/data/request/ai_bot/update_assistant_request.dart';
import 'package:jarvis/data/request/ai_chat/conversation/conversation_history_request.dart';
import 'package:jarvis/data/request/ai_chat/conversation/conversations_request.dart';
import 'package:jarvis/data/request/ai_chat/send_message/send_message_request.dart';
import 'package:jarvis/data/request/authentication_kb/knowledge_auth_request.dart';
import 'package:jarvis/data/request/bot_integration/disconnect_bot_integration_request.dart';
import 'package:jarvis/data/request/bot_integration/get_configurations_request.dart';
import 'package:jarvis/data/request/bot_integration/publish_messenger_bot_request.dart';
import 'package:jarvis/data/request/bot_integration/publish_slack_bot_request.dart';
import 'package:jarvis/data/request/bot_integration/publish_telegram_bot_request.dart';
import 'package:jarvis/data/request/bot_integration/verify_messenger_bot_integration_request.dart';
import 'package:jarvis/data/request/bot_integration/verify_slack_bot_integration_request.dart';
import 'package:jarvis/data/request/bot_integration/verify_telegram_bot_integration_request.dart';
import 'package:jarvis/data/request/email/create_email_reply_request.dart';
import 'package:jarvis/data/request/email/create_response_email_request.dart';
import 'package:jarvis/data/responses/ai_bot/get_assistants_response.dart';
import 'package:jarvis/data/responses/bot_integration/get_configurations_response.dart';
import 'package:jarvis/data/responses/email/create_email_reply_response.dart';
import 'package:jarvis/data/responses/email/create_response_email_response.dart';
import 'package:jarvis/domain/model/model.dart';
import 'package:jarvis/data/request/authentication/request.dart';
import 'package:jarvis/data/responses/authentication_kb/knowledge_auth_response.dart';
import '../../../app/constant.dart';


abstract class Repository {
  Future<Either<Failure, Token>> signIn(SignInRequest signInRequest);
  Future<Either<Failure, User>> signUp(SignUpRequest signUpRequest);
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, Token>> refreshToken(String refreshTokenRequest);
  Future<Either<Failure, Message>> sendMessage(SendMessageRequest sendMessageRequest);
  Future<Either<Failure, TokenUsage>> getTokenUsage();
  Future<Either<Failure, Conversations>> getConversations(ConversationsRequest conversationsRequest);
  Future<Either<Failure, ConversationHistory>> getConversationHistory(ConversationHistoryRequest conversationsRequest);
  Future<Either<Failure, Token>> signInKnowledgeBase(KnowledgeAuthRequest signInKbRequest);
  // Future<Either<Failure, GetAssistantsResponse>> getAssistants(GetAssistantsRequest getAssistantsRequest);
  Future<Either<Failure, KnowledgeResponse>> createKnowledge(CreateKnowledgeRequest request);
  Future<Either<Failure, KnowledgeResponse>> updateKnowledge(String id, CreateKnowledgeRequest request);
  Future<Either<Failure, GetKnowledgeResponse>> getKnowledge({
    int? limit,
    int? offset,
    EnumOrder? order,
    String? orderField,
    String? q,
  });
  Future<Either<Failure, GetUnitsResponse>> getUnits({
    required String id,
    int? limit,
    int? offset,
    EnumOrder? order,
    String? orderField,
    String? q,
  });
  Future<Either<Failure, void>> deleteKnowledge(String id);
  Future<Either<Failure, UnitResponse>> uploadLocalFile(String knowledgeId, File file);
  Future<Either<Failure, UnitResponse>> uploadSlackFile(String id, UploadSlackFileRequest request);
  Future<Either<Failure, UnitResponse>> uploadWebFile(String id, UploadWebFileRequest request);
  Future<Either<Failure, UnitResponse>> uploadConfluenceFile(String id, UploadConfluenceFileRequest request);
  Future<Either<Failure, Assistants>> getAssistants(GetAssistantsRequest getAssistantsRequest);
  Future<Either<Failure, AssistantCustom>> getAssistant(GetAssistantRequest getAssistantRequest);
  Future<Either<Failure, AssistantCustom>> createAssistant(CreateAssistantRequest createAssistantRequest);
  Future<Either<Failure, AssistantCustom>> updateAssistant(UpdateAssistantRequest updateAssistantRequest);
  Future<Either<Failure, AssistantCustom>> updateAssistantNewThreadPlayGround(UpdateAssistantNewThreadPlayGroundRequest updateAssistantNewThreadPlayGroundRequest);
  Future<Either<Failure, void>> deleteAssistant(DeleteAssistantRequest deleteAssistantRequest);
  Future<Either<Failure, MessageAssistant>> askAssistant(AskAssistantRequest askAssistantRequest);
  Future<Either<Failure, MessageAssistants>> retrieveMessageThread(RetrieveMessageThreadRequest retrieveMessageThreadRequest);
  Future<Either<Failure, Thread>> createThread(CreateThreadRequest createThreadRequest);
  Future<Either<Failure, List<Configuration>>> getConfigurations(GetConfigurationsRequest getConfigurationsRequest);
  Future<Either<Failure, void>> verifyBotSlackIntegration(VerifySlackBotIntegrationRequest verifySlackBotIntegrationRequest);
  Future<Either<Failure, void>> verifyBotMessengerIntegration(VerifyMessengerBotIntegrationRequest verifyMessengerBotIntegrationRequest);
  Future<Either<Failure, void>> verifyBotTelegramIntegration(VerifyTelegramBotIntegrationRequest verifyTelegramBotIntegrationRequest);
  Future<Either<Failure, void>> publishBotTelegramIntegration(PublishTelegramBotRequest publishTelegramBotRequest);
  Future<Either<Failure, void>> publishBotSlackIntegration(PublishSlackBotRequest publishSlackBotRequest);
  Future<Either<Failure, void>> publishBotMessengerIntegration(PublishMessengerBotRequest publishMessengerBotRequest);
  Future<Either<Failure, void>> disconnectBotIntegration(DisconnectBotIntegrationRequest disconnectBotIntegrationRequest);
  Future<Either<Failure, CreateEmailReplyResponse>> createEmailReply(CreateEmailReplyRequest emailReplyRequest);
  Future<Either<Failure, CreateResponseEmailResponse>> createResponseEmail(CreaterResponseEmailRequest responseEmailRequest);
}
