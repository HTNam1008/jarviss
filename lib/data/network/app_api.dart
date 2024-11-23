// app_api.dart

import 'package:dio/dio.dart';
import 'package:jarvis/app/constant.dart';
import 'package:jarvis/data/request/ai_chat/send_message/send_message_request.dart';
import 'package:jarvis/data/responses/ai_chat/get_conversation_history_response.dart';
import 'package:jarvis/data/responses/ai_chat/get_conversations_response.dart';
import 'package:jarvis/data/responses/ai_chat/send_message_response.dart';
import 'package:jarvis/data/responses/responses.dart';
import 'package:jarvis/data/request/authentication/request.dart';
import 'package:jarvis/data/responses/token/token_usage_response.dart';
import 'package:retrofit/retrofit.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;
  
  @POST(ConstantAPI.signIn)
  Future<SignInResponse> signIn(
    @Body() SignInRequest request,
  );

  @POST(ConstantAPI.signUp)
  Future<SignUpResponse> signUp(
    @Body() SignUpRequest request,
  );

  @GET(ConstantAPI.signOut)
  Future<void> signOut();

  @GET(ConstantAPI.refreshToken)
  Future<RefreshTokenResponse> refreshToken(
    @Query('refreshToken') String refreshToken,
  );

  @POST(ConstantAPI.sendMessage)
  Future<SendMessageResponse> sendMessage(
    @Body() SendMessageRequest request,
  );

  @GET(ConstantAPI.tokenUsage)
  Future<TokenUsageResponse> getTokenUsage();

  @GET(ConstantAPI.getConversations)
  Future<ConversationsResponse> getConversations(
    @Query('assistantId') String assistandId,
    @Query('assistantModel') String assistantModel,
    @Query('cursor') String? cursor,
  );

  @GET("/api/v1/ai-chat/conversations/{conversationId}/messages")
  Future<ConversationHistoryResponse> getConversationHistory(
    @Path("conversationId") String conversationId, 
    @Query('assistantId') String assistandId,
    @Query('assistantModel') String assistantModel,
  );
}
