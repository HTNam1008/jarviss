import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/src/multipart_file.dart';
import 'package:http_parser/http_parser.dart';
import 'package:jarvis/data/network/app_api.dart';
import 'package:jarvis/data/network/app_kb_api.dart';
import 'package:jarvis/data/request/ai_bot/delete_assistant_request.dart';
import 'package:jarvis/data/request/ai_bot/get_assistant_request.dart';
import 'package:jarvis/data/request/ai_bot/get_assistants_request.dart';
import 'package:jarvis/data/request/ai_bot/update_assistant_request.dart';
import 'package:jarvis/data/request/ai_chat/conversation/conversation_history_request.dart';
import 'package:jarvis/data/request/ai_chat/conversation/conversations_request.dart';
import 'package:jarvis/data/request/ai_chat/send_message/send_message_request.dart';
import 'package:jarvis/data/request/authentication/request.dart';
import 'package:jarvis/data/request/authentication_kb/knowledge_auth_request.dart';
import 'package:jarvis/data/responses/ai_bot/get_assistant_response.dart';
import 'package:jarvis/data/responses/ai_bot/get_assistants_response.dart';
import 'package:jarvis/data/responses/ai_bot/update_assistant_response.dart';
import 'package:jarvis/data/responses/ai_chat/get_conversation_history_response.dart';
import 'package:jarvis/data/responses/ai_chat/get_conversations_response.dart';
import 'package:jarvis/data/responses/ai_chat/send_message_response.dart';
import 'package:jarvis/data/responses/authentication_kb/knowledge_auth_response.dart';
import 'package:jarvis/data/responses/responses.dart';
import 'package:jarvis/data/responses/token/token_usage_response.dart';
import '../../../app/constant.dart';


abstract class RemoteDataSource {
  Future<SignInResponse> signIn(SignInRequest signInRequest);
  Future<SignUpResponse> signUp(SignUpRequest signUpRequest);
  Future<void> signOut();
  Future<RefreshTokenResponse> refreshToken(String refreshTokenRequest);
  Future<SendMessageResponse> sendMessage(
      SendMessageRequest sendMessageRequest);
  Future<TokenUsageResponse> getTokenUsage();
  Future<ConversationsResponse> getConversations(
      ConversationsRequest conversationsRequest);
  Future<ConversationHistoryResponse> getConversationHistory(
      ConversationHistoryRequest conversationHistoryRequest);
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
  Future<KnowledgeAuthResponse> signInKnowledgeBase(
      KnowledgeAuthRequest signInRequest);
  Future<GetAssistantsResponse> getAssistants(
      GetAssistantsRequest getAssistantsRequest);
  Future<GetAssistantResponse> getAssistant(
      GetAssistantRequest getAssistantRequest);
  Future<void> deleteAssistant(DeleteAssistantRequest deleteAssistantRequest);
  Future<UpdateAssistantResponse> updateAssistant(
      UpdateAssistantRequest updateAssistantRequest);
  Future<KnowledgeResponse> createKnowledge(CreateKnowledgeRequest request);
  Future<KnowledgeResponse> updateKnowledge(String id, CreateKnowledgeRequest request);
  Future<GetKnowledgeResponse> getKnowledge({
    int? limit,
    int? offset,
    EnumOrder? order,
    String? orderField,
    String? q,
  });
  Future<GetUnitsResponse> getUnits({
    required String id,
    int? limit,
    int? offset,
    EnumOrder? order,
    String? orderField,
    String? q,
  });
  Future<void> deleteKnowledge(String id);
  Future<UnitResponse> uploadLocalFile(String id, File file);
  Future<UnitResponse> uploadWebFile(String id, UploadWebFileRequest request);
  Future<UnitResponse> uploadSlackFile(String id, UploadSlackFileRequest request);
  Future<UnitResponse> uploadConfluenceFile(String id, UploadConfluenceFileRequest request);
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
  Future<SendMessageResponse> sendMessage(
      SendMessageRequest sendMessageRequest) async {
    return await _appServiceClient.sendMessage(sendMessageRequest);
  }

  @override
  Future<TokenUsageResponse> getTokenUsage() async {
    return await _appServiceClient.getTokenUsage();
  }

  @override
  Future<ConversationsResponse> getConversations(
      ConversationsRequest conversationsRequest) async {
    return await _appServiceClient.getConversations(
        conversationsRequest.assistandId,
        conversationsRequest.assistantModel,
        conversationsRequest.cursor);
  }

  @override
  Future<ConversationHistoryResponse> getConversationHistory(
      ConversationHistoryRequest conversationHistoryRequest) async {
    return await _appServiceClient.getConversationHistory(
        conversationHistoryRequest.conversationId,
        conversationHistoryRequest.assistandId,
        conversationHistoryRequest.assistantModel,
        conversationHistoryRequest.cursor);
  }

  @override
  Future<GetPromptsResponse> getPrompts(String? category, bool isPublic,
      {bool? isFavorite, String? query, int? limit}) async {
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
  Future<void> updatePrompt(
      String promptId, UpdatePromptRequest request) async {
    return await _appServiceClient.updatePrompt(promptId, request);
  }

  @override
  Future<void> deletePrompt(String promptId) async {
    return await _appServiceClient.deletePrompt(promptId);
  }

  @override
  Future<KnowledgeAuthResponse> signInKnowledgeBase(
      KnowledgeAuthRequest signInRequest) async {
    return await _appKbServiceClient.signInKnowledgeBase(signInRequest);
  }

  @override
  Future<void> deleteAssistant(
      DeleteAssistantRequest deleteAssistantRequest) async {
    return await _appKbServiceClient
        .deleteAssistant(deleteAssistantRequest.assistantId);
  }

  @override
  Future<GetAssistantResponse> getAssistant(
      GetAssistantRequest getAssistantRequest) async {
    return await _appKbServiceClient
        .getAssistant(getAssistantRequest.assistantId);
  }

  @override
  Future<UpdateAssistantResponse> updateAssistant(
      UpdateAssistantRequest updateAssistantRequest) async {
    return await _appKbServiceClient.updateAssistant(
        updateAssistantRequest.assistantId, updateAssistantRequest);
  }

  @override
  Future<GetAssistantsResponse> getAssistants(
      GetAssistantsRequest getAssistantsRequest) async {
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
  Future<KnowledgeResponse> createKnowledge(CreateKnowledgeRequest request) =>
      _appKbServiceClient.createKnowledge(request);

  @override
  Future<KnowledgeResponse> updateKnowledge(String id, CreateKnowledgeRequest request) =>
      _appKbServiceClient.updateKnowledge(id, request);

  @override
  Future<GetKnowledgeResponse> getKnowledge({int? limit, int? offset, EnumOrder? order,String? orderField,String? q,}) async {
    log('Fetched knowledge datasource');
    try {
      final response = await _appKbServiceClient.getKnowledge(
        limit: limit,
        offset: offset,
        order: order,
        orderField: orderField,
        q: q,);
      log('API call successful: $response');
      return response;
    } catch (e, stackTrace) {
      log('Error in _remoteDataSource.getKnowledge: $e', stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<GetUnitsResponse> getUnits({required String id, int? limit, int? offset, EnumOrder? order,String? orderField,String? q,}) async {
    log('Fetched knowledge datasource');
    try {
      final response = await _appKbServiceClient.getUnits(
        knowledgeId: id,
        limit: limit,
        offset: offset,
        order: order,
        orderField: orderField,
        q: q,);
      log('API call successful: $response');
      return response;
    } catch (e, stackTrace) {
      log('Error in _remoteDataSource.getKnowledge: $e', stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> deleteKnowledge(String id) =>
      _appKbServiceClient.deleteKnowledge(id);

  @override
  Future<UnitResponse> uploadLocalFile(String id, File file) async {
    String? mimeType = FileUploadHelper.getMimeType(file.path);
    if (mimeType == null) {
      throw Exception('Unsupported file format');
    }
    // Convert the file to MultipartFile
    MultipartFile multipartFile = await MultipartFile.fromFile(
      file.path,
      filename: file.path.split('/').last,
      contentType: MediaType.parse(mimeType), // Adjust for your file type
    );

    // Create FormData with the MultipartFile
    FormData formData = FormData.fromMap({
      'file': multipartFile,
    });

    // Debugging: Log FormData content
    print('Uploading file: ${file.path}');
    print('FormData: ${formData.files.map((f) => f.value.filename).toList()}');

    // Call the API
    return await _appKbServiceClient.uploadLocalFile(id, formData);
  }

  @override
  Future<UnitResponse> uploadWebFile(String id, UploadWebFileRequest request) =>
      _appKbServiceClient.uploadWebFile(id, request);

  @override
  Future<UnitResponse> uploadSlackFile(String id, UploadSlackFileRequest request) =>
      _appKbServiceClient.uploadSlackFile(id, request);

  @override
  Future<UnitResponse> uploadConfluenceFile(String id, UploadConfluenceFileRequest request) =>
      _appKbServiceClient.uploadConfluenceFile(id, request);
}

class FileUploadHelper {
  // Map of file extensions to MIME types
  static const Map<String, String> mimeTypes = {
    '.c': 'text/x-c',
    '.cpp': 'text/x-c++',
    '.docx': 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    '.html': 'text/html',
    '.java': 'text/x-java',
    '.json': 'application/json',
    '.md': 'text/markdown',
    '.pdf': 'application/pdf',
    '.php': 'text/x-php',
    '.pptx': 'application/vnd.openxmlformats-officedocument.presentationml.presentation',
    '.py': 'text/x-python',
    '.rb': 'text/x-ruby',
    '.tex': 'text/x-tex',
    '.txt': 'text/plain',
  };

  // Method to determine MIME type based on file extension
  static String? getMimeType(String filePath) {
    final extension = filePath.split('.').last.toLowerCase();
    return mimeTypes['.$extension'];
  }
}