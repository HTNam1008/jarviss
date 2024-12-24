import 'package:jarvis/data/network/app_api.dart';
import 'package:jarvis/data/network/app_kb_api.dart';
import 'package:jarvis/data/request/ai_bot/ask_assistant_request.dart';
import 'package:jarvis/data/request/ai_bot/create_assistant_request.dart';
import 'package:jarvis/data/request/ai_bot/delete_assistant_request.dart';
import 'package:jarvis/data/request/ai_bot/get_assistant_request.dart';
import 'package:jarvis/data/request/ai_bot/get_assistants_request.dart';
import 'package:jarvis/data/request/ai_bot/retrieve_message_thread_request.dart';
import 'package:jarvis/data/request/ai_bot/update_assistant_new_thread_playground_request.dart';
import 'package:jarvis/data/request/ai_bot/update_assistant_request.dart';
import 'package:jarvis/data/request/ai_chat/conversation/conversation_history_request.dart';
import 'package:jarvis/data/request/ai_chat/conversation/conversations_request.dart';
import 'package:jarvis/data/request/ai_chat/send_message/send_message_request.dart';
import 'package:jarvis/data/request/authentication/request.dart';
import 'package:jarvis/data/request/authentication_kb/knowledge_auth_request.dart';
import 'package:jarvis/data/responses/ai_bot/create_assistant_response.dart';
import 'package:jarvis/data/responses/ai_bot/get_assistant_response.dart';
import 'package:jarvis/data/responses/ai_bot/get_assistants_response.dart';
import 'package:jarvis/data/responses/ai_bot/retrieve_message_thread_response.dart';
import 'package:jarvis/data/responses/ai_bot/update_assistant_new_thread_playground_response.dart';
import 'package:jarvis/data/responses/ai_bot/update_assistant_response.dart';
import 'package:jarvis/data/responses/ai_chat/get_conversation_history_response.dart';
import 'package:jarvis/data/responses/ai_chat/get_conversations_response.dart';
import 'package:jarvis/data/responses/ai_chat/send_message_response.dart';
import 'package:jarvis/data/responses/authentication_kb/knowledge_auth_response.dart';
import 'package:jarvis/data/responses/responses.dart';
import 'package:jarvis/data/responses/token/token_usage_response.dart';

abstract class RemoteDataSource {
  Future<SignInResponse> signIn(SignInRequest signInRequest);
  Future<SignUpResponse> signUp(SignUpRequest signUpRequest);
  Future<void> signOut();
  Future<RefreshTokenResponse> refreshToken(String refreshTokenRequest);
  Future<SendMessageResponse> sendMessage(SendMessageRequest sendMessageRequest);
  Future<TokenUsageResponse> getTokenUsage();
  Future<ConversationsResponse> getConversations(ConversationsRequest conversationsRequest);
  Future<ConversationHistoryResponse> getConversationHistory(ConversationHistoryRequest conversationHistoryRequest);
  Future<GetPromptsResponse> getPrompts(
    String? category,
    bool isPublic, {
    bool? isFavorite,
    String? query,
    int? limit,
  });
  Future<void> addToFavorites(String promptId);
  Future<PromptResponse> createPrompt(CreatePromptRequest request);
  Future<void> updatePrompt(String promptId, UpdatePromptRequest request);
  Future<void> deletePrompt(String promptId);
  Future<KnowledgeAuthResponse> signInKnowledgeBase(KnowledgeAuthRequest signInRequest);
  Future<GetAssistantsResponse> getAssistants(GetAssistantsRequest getAssistantsRequest);
  Future<GetAssistantResponse> getAssistant(GetAssistantRequest getAssistantRequest);
  Future<void> deleteAssistant(DeleteAssistantRequest deleteAssistantRequest);
  Future<UpdateAssistantResponse> updateAssistant(UpdateAssistantRequest updateAssistantRequest);
  Future<UpdateAssistantNewThreadPlayGroundResponse> updateAssistantNewThreadPlayGround(UpdateAssistantNewThreadPlayGroundRequest updateAssistantNewThreadPlayGroundRequest);
  Future<CreateAssistantResponse> createAssistant(CreateAssistantRequest createAssistantRequest);
  Future<String> askAssistant(AskAssistantRequest createAssistantRequest);
  Future<RetrieveMessageThreadResponse> retrieveMessageThread(RetrieveMessageThreadRequest retrieveMessageThreadRequest);
}

class RemoteDataSourceImplementer implements RemoteDataSource {
  final AppServiceClient _appServiceClient;
  final AppKbServiceClient _appKbServiceClient;

  RemoteDataSourceImplementer(this._appServiceClient, this._appKbServiceClient);

  @override
  Future<SignInResponse> signIn(SignInRequest signInRequest) async {
    return await _appServiceClient.signIn(signInRequest);
  }

  @override
  Future<SignUpResponse> signUp(SignUpRequest signUpRequest) async {
    return await _appServiceClient.signUp(signUpRequest);
  }

  @override
  Future<void> signOut() async {
    return await _appServiceClient.signOut();
  }

  @override
  Future<RefreshTokenResponse> refreshToken(String refreshTokenRequest) async {
    return await _appServiceClient.refreshToken(refreshTokenRequest);
  }

  @override
  Future<SendMessageResponse> sendMessage(SendMessageRequest sendMessageRequest) async {
    return await _appServiceClient.sendMessage(sendMessageRequest);
  }

  @override
  Future<TokenUsageResponse> getTokenUsage() async {
    return await _appServiceClient.getTokenUsage();
  }

  @override
  Future<ConversationsResponse> getConversations(ConversationsRequest conversationsRequest) async {
    return await _appServiceClient.getConversations(conversationsRequest.assistandId, conversationsRequest.assistantModel, conversationsRequest.cursor);
  }

  @override
  Future<ConversationHistoryResponse> getConversationHistory(ConversationHistoryRequest conversationHistoryRequest) async {
    return await _appServiceClient.getConversationHistory(conversationHistoryRequest.conversationId, conversationHistoryRequest.assistandId,
        conversationHistoryRequest.assistantModel, conversationHistoryRequest.cursor);
  }

  @override
  Future<GetPromptsResponse> getPrompts(String? category, bool isPublic, {bool? isFavorite, String? query, int? limit}) async {
    return await _appServiceClient.getPrompts(
      category,
      isPublic,
      isFavorite,
      query,
      limit,
    );
  }

  @override
  Future<void> addToFavorites(String promptId) async {
    return await _appServiceClient.addPromptToFavorite(promptId);
  }

  @override
  Future<PromptResponse> createPrompt(CreatePromptRequest request) async {
    return await _appServiceClient.createPrompt(request);
  }

  @override
  Future<void> updatePrompt(String promptId, UpdatePromptRequest request) async {
    return await _appServiceClient.updatePrompt(promptId, request);
  }

  @override
  Future<void> deletePrompt(String promptId) async {
    return await _appServiceClient.deletePrompt(promptId);
  }

  @override
  Future<KnowledgeAuthResponse> signInKnowledgeBase(KnowledgeAuthRequest signInRequest) async {
    return await _appKbServiceClient.signInKnowledgeBase(signInRequest);
  }

  @override
  Future<void> deleteAssistant(DeleteAssistantRequest deleteAssistantRequest) async {
    return await _appKbServiceClient.deleteAssistant(deleteAssistantRequest.assistantId);
  }

  @override
  Future<GetAssistantResponse> getAssistant(GetAssistantRequest getAssistantRequest) async {
    // const assistantId = "b0c0c146-2bab-49eb-80e5-69ece1e17775";
    return await _appKbServiceClient.getAssistant(getAssistantRequest.assistantId);
    // .getAssistant(assistantId);
  }

  @override
  Future<UpdateAssistantResponse> updateAssistant(UpdateAssistantRequest updateAssistantRequest) async {
    return await _appKbServiceClient.updateAssistant(updateAssistantRequest.assistantId, updateAssistantRequest);
  }

  @override
  Future<GetAssistantsResponse> getAssistants(GetAssistantsRequest getAssistantsRequest) async {
    return await _appKbServiceClient.getAssistants(
        isFavorite: getAssistantsRequest.isFavorite,
        isPublished: getAssistantsRequest.isPublished,
        limit: getAssistantsRequest.limit,
        offset: getAssistantsRequest.offset,
        order: getAssistantsRequest.order,
        orderField: getAssistantsRequest.orderField,
        q: getAssistantsRequest.q);
  }

  @override
  Future<CreateAssistantResponse> createAssistant(CreateAssistantRequest createAssistantRequest) async {
    return await _appKbServiceClient.createAssistant(createAssistantRequest);
  }

  @override
  Future<String> askAssistant(AskAssistantRequest askAssistantRequest) async {
    return await _appKbServiceClient.askAssistant(askAssistantRequest.assistandId, askAssistantRequest);
  }
  
  @override
  Future<RetrieveMessageThreadResponse> retrieveMessageThread(RetrieveMessageThreadRequest retrieveMessageThreadRequest) async {
    return await _appKbServiceClient.retrieveMessageThread(retrieveMessageThreadRequest.openAiThreadId);
  }
  
  @override
  Future<UpdateAssistantNewThreadPlayGroundResponse> updateAssistantNewThreadPlayGround(UpdateAssistantNewThreadPlayGroundRequest updateAssistantNewThreadPlayGroundRequest) async {
    return await _appKbServiceClient.updateAssistantNewThreadPlayGround(updateAssistantNewThreadPlayGroundRequest);
  }
}
