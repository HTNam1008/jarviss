// app_api.dart

import 'package:dio/dio.dart';
import 'package:jarvis/app/constant.dart';
import 'package:jarvis/data/request/ai_chat/send_message/send_message_request.dart';
import 'package:jarvis/data/responses/ai_chat/send_message_response.dart';
import 'package:jarvis/data/responses/responses.dart';
import 'package:jarvis/data/request/request.dart';
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

  @GET("/api/v1/prompts")
  Future<GetPromptsResponse> getPrompts(
      @Query("category") String? category,
      @Query("isPublic") bool isPublic,
      @Query("isFavorite") bool? isFavorite,
      );

  @POST("/api/v1/prompts/{id}/favorite")
  Future<void> addPromptToFavorite(@Path("id") String promptId);

  @POST("/api/v1/prompts")
  Future<PromptResponse> createPrompt(@Body() CreatePromptRequest request);
}
