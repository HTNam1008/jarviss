import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:jarvis/app/constant.dart';
import 'package:jarvis/data/request/ai_bot/ask_assistant_request.dart';
import 'package:jarvis/data/request/ai_bot/create_assistant_request.dart';
import 'package:jarvis/data/request/ai_bot/create_thread_request.dart';
import 'package:jarvis/data/request/ai_bot/update_assistant_new_thread_playground_request.dart';
import 'package:jarvis/data/request/ai_bot/update_assistant_request.dart';
import 'package:jarvis/data/request/authentication_kb/knowledge_auth_request.dart';
import 'package:jarvis/data/request/bot_integration/publish_messenger_bot_request.dart';
import 'package:jarvis/data/request/bot_integration/publish_slack_bot_request.dart';
import 'package:jarvis/data/request/bot_integration/publish_telegram_bot_request.dart';
import 'package:jarvis/data/request/bot_integration/verify_messenger_bot_integration_request.dart';
import 'package:jarvis/data/request/bot_integration/verify_slack_bot_integration_request.dart';
import 'package:jarvis/data/request/bot_integration/verify_telegram_bot_integration_request.dart';
import 'package:jarvis/data/responses/ai_bot/create_assistant_response.dart';
import 'package:jarvis/data/responses/ai_bot/create_thread_response.dart';
import 'package:jarvis/data/responses/ai_bot/get_assistant_response.dart';
import 'package:jarvis/data/responses/ai_bot/get_assistants_response.dart';
import 'package:jarvis/data/responses/ai_bot/get_imported_knowledge_response.dart';
import 'package:jarvis/data/responses/ai_bot/get_knowledge_relation_response.dart';
import 'package:jarvis/data/responses/ai_bot/retrieve_message_thread_response.dart';
import 'package:jarvis/data/responses/ai_bot/update_assistant_new_thread_playground_response.dart';
import 'package:jarvis/data/responses/ai_bot/update_assistant_response.dart';
import 'package:jarvis/data/responses/authentication_kb/knowledge_auth_response.dart';
import 'package:jarvis/data/responses/bot_integration/get_configurations_response.dart';
import 'package:jarvis/data/responses/bot_integration/publish_bot_response.dart';
import 'package:retrofit/retrofit.dart';

import '../request/knowledge/create_knowledge_request.dart';
import '../request/knowledge/upload_confluence_file_request.dart';
import '../request/knowledge/upload_slack_file_request.dart';
import '../request/knowledge/upload_web_file_request.dart';
import '../responses/knowledge/get_knowledge_response.dart';
import '../responses/knowledge/get_units_response.dart';
import '../responses/knowledge/knowledge_response.dart';
import '../responses/knowledge/unit_response.dart';
part 'app_kb_api.g.dart';

@RestApi(baseUrl: Constant.baseKnowledgeUrl)
abstract class AppKbServiceClient {
  factory AppKbServiceClient(Dio dio, {String baseUrl}) = _AppKbServiceClient;

  @POST(ConstantAPI.signInKnowledgeBase)
  Future<KnowledgeAuthResponse> signInKnowledgeBase(
    @Body() KnowledgeAuthRequest knowledgeAuthRequest,
  );

  @POST(ConstantAPI.createAssistant)
  Future<CreateAssistantResponse> createAssistant(
    @Body() CreateAssistantRequest createAssistantRequest,
  );

  @DELETE(ConstantAPI.deleteAssistant)
  Future<void> deleteAssistant(@Path(ConstantPath.assistantId) String assistantId);

  @PATCH(ConstantAPI.updateAssistant)
  Future<UpdateAssistantResponse> updateAssistant(
    @Path(ConstantPath.assistantId) String assistantId,
    @Body() UpdateAssistantRequest updateAssistantRequest,
  );

  @GET(ConstantAPI.getAssistants)
  Future<GetAssistantsResponse> getAssistants({
    @Query('isFavorite') bool? isFavorite,
    @Query('isPublished') bool? isPublished,
    @Query('limit') double? limit,
    @Query('offset') double? offset,
    @Query('order') EnumOrder? order,
    @Query('orderField') String? orderField,
    @Query('q') String? q,
  });

  @GET(ConstantAPI.getAssistant)
  Future<GetAssistantResponse> getAssistant(@Path(ConstantPath.assistantId) String assistandId);

  @POST(ConstantAPI.createKnowledge)
  Future<KnowledgeResponse> createKnowledge(@Body() CreateKnowledgeRequest knowledgeData);

  @PATCH("/kb-core/v1/knowledge/{id}")
  Future<KnowledgeResponse> updateKnowledge(
      @Path("id") String knowledgeId,
      @Body() CreateKnowledgeRequest knowledgeData);

  @GET(ConstantAPI.getKnowledge)
  Future<GetKnowledgeResponse> getKnowledge({
    @Query('limit') int? limit,
    @Query('offset') int? offset,
    @Query('order') EnumOrder? order,
    @Query('orderField') String? orderField,
    @Query('q') String? q,
  });

  @GET('/kb-core/v1/knowledge/{id}/units')
  Future<GetUnitsResponse> getUnits({
    @Path("id") required String knowledgeId,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
    @Query('order') EnumOrder? order,
    @Query('orderField') String? orderField,
    @Query('q') String? q,
  });

  @DELETE("/kb-core/v1/knowledge/{id}")
  Future<void> deleteKnowledge(@Path("id") String knowledgeId);

  @POST("/kb-core/v1/knowledge/{id}/local-file")
  @MultiPart()
  Future<UnitResponse> uploadLocalFile(
      @Path("id") String knowledgeId,
      @Body() FormData formData);

  @POST("/kb-core/v1/knowledge/{id}/web")
  Future<UnitResponse> uploadWebFile(
      @Path("id") String knowledgeId,
      @Body() UploadWebFileRequest request);

  @POST("/kb-core/v1/knowledge/{id}/slack")
  Future<UnitResponse> uploadSlackFile(
      @Path("id") String knowledgeId,
      @Body() UploadSlackFileRequest request);

  @POST("/kb-core/v1/knowledge/{id}/confluence")
  Future<UnitResponse> uploadConfluenceFile(
      @Path("id") String knowledgeId,
      @Body() UploadConfluenceFileRequest request);

  @POST(ConstantAPI.askAssistant)
  Future<String> askAssistant(
    @Path(ConstantPath.assistantId) String assistandId,
    @Body() AskAssistantRequest askAssistantRequest,
  );

  @GET(ConstantAPI.retrieveMessageThread)
  Future<RetrieveMessageThreadResponse> retrieveMessageThread(
    @Path(ConstantPath.openAiThreadId) String openAiThreadId,
  );

  @POST(ConstantAPI.updateAssistantNewThreadPlayGround)
  Future<UpdateAssistantNewThreadPlayGroundResponse> updateAssistantNewThreadPlayGround(
    @Body() UpdateAssistantNewThreadPlayGroundRequest updateAssistantNewThreadPlayGroundRequest,
  );
  
  @POST(ConstantAPI.createThread)
  Future<CreateThreadResponse> createThread(
    @Body() CreateThreadRequest createThreadRequest,
  );

  @POST(ConstantAPI.importKnowledgeToAssistant)
  Future<void> importKnowledgeToAssistant(
    @Path(ConstantPath.assistantId) String assistantId,
    @Path(ConstantPath.knowledgeId) String knowledgeId,
  );

  @DELETE(ConstantAPI.removeKnowledgeFromAssistant)
  Future<void> removeKnowledgeFromAssistant(
    @Path(ConstantPath.assistantId) String assistantId,
    @Path(ConstantPath.knowledgeId) String knowledgeId,
  );

  @GET(ConstantAPI.getImportedKnowledge)
  Future<GetImportedKnowledgeResponse> getImportedKnowledge(
    @Path(ConstantPath.assistantId) String assistantId,
    @Query('limit') double? limit,
    @Query('offset') double? offset,
    @Query('order') EnumOrder? order,
    @Query('orderField') String? orderField,
    @Query('q') String? q,
  );

  @GET(ConstantAPI.getConfigurations)
  Future<GetConfigurationsResponse> getConfigurations(
    @Path(ConstantPath.assistantId) String assistantId,
  );

  @DELETE(ConstantAPI.disconnectBotIntegration)
  Future<void> disconnectBotIntegration(
    @Path(ConstantPath.assistantId) String assistantId,
    @Path(ConstantPath.type) String type,
  );

  @POST(ConstantAPI.verifyTelegramBotConfigure)
  Future<void> verifyTelegramBotConfigure(
    @Body() VerifyTelegramBotIntegrationRequest verifyTelegramBotIntegrationRequest,
  );

  @POST(ConstantAPI.verifySlackBotConfigure)
  Future<void> verifySlackBotConfigure(
    @Body() VerifySlackBotIntegrationRequest verifySlackBotConfigureRequest,
  );

  @POST(ConstantAPI.verifyMessengerBotConfigure)
  Future<void> verifyMessengerBotConfigure(
    @Body() VerifyMessengerBotIntegrationRequest verifyMessengerBotConfigureRequest,
  );

  @POST(ConstantAPI.publishMessengerBot)
  Future<PublishBotResponse> publishMessengerBot(
    @Path(ConstantPath.assistantId) String assistantId,
    @Body() PublishMessengerBotRequest  publishMessengerBotRequest,
  );

  @POST(ConstantAPI.publishTelegramBot)
  Future<PublishBotResponse> publishTelegramBot(
    @Path(ConstantPath.assistantId) String assistantId,
    @Body() PublishTelegramBotRequest  publishTelegramBotRequest,
  );

  @POST(ConstantAPI.publishSlackBot)
  Future<PublishBotResponse> publishSlackBot(
    @Path(ConstantPath.assistantId) String assistantId,
    @Body() PublishSlackBotRequest  publishSlackBotRequest,
  );

  @GET(ConstantAPI.getKnowledgeRelation)
  Future<GetKnowledgeRelationResponse> getKnowledgeRelation(
    @Path(ConstantPath.assistantId) String assistantId,
    @Query('limit') double? limit,
    @Query('offset') double? offset,
  );
}
