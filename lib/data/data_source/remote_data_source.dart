import 'dart:developer';

import 'package:jarvis/data/network/app_api.dart';
import 'package:jarvis/data/request/ai_chat/send_message/send_message_request.dart';
import 'package:jarvis/data/request/ai_chat/authentication/request.dart';
import 'package:jarvis/data/responses/ai_chat/send_message_response.dart';
import 'package:jarvis/data/responses/responses.dart';
import 'package:jarvis/data/responses/token/token_usage_response.dart';

import '../request/request.dart';

abstract class RemoteDataSource {
  Future<SignInResponse> signIn(SignInRequest signInRequest);
  Future<SignUpResponse> signUp(SignUpRequest signUpRequest);
  Future<void> signOut();
  Future<RefreshTokenResponse> refreshToken(String refreshTokenRequest);
  Future<SendMessageResponse> sendMessage(SendMessageRequest sendMessageRequest);
  Future<TokenUsageResponse> getTokenUsage();
  Future<GetPromptsResponse> getPrompts(String? category, bool isPublic,  {bool? isFavorite, String? query});
  Future<void> addToFavorites(String promptId);
  Future<PromptResponse> createPrompt(CreatePromptRequest request);
  Future<void> updatePrompt(String promptId, UpdatePromptRequest request);
  Future<void> deletePrompt(String promptId);
}

class RemoteDataSourceImplementer implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImplementer(this._appServiceClient);

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
  Future<GetPromptsResponse> getPrompts(String? category, bool isPublic,  {bool? isFavorite, String? query}) async {
    return await _appServiceClient.getPrompts(category, isPublic, isFavorite, query);
  }

  @override
  Future<void> addToFavorites(String promptId) async {
    return await _appServiceClient.addPromptToFavorite(promptId);
  }

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
}
