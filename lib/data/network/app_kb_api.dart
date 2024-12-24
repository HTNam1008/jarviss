import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:jarvis/app/constant.dart';
import 'package:jarvis/data/request/ai_bot/create_assistant_request.dart';
import 'package:jarvis/data/request/ai_bot/update_assistant_request.dart';
import 'package:jarvis/data/request/authentication_kb/knowledge_auth_request.dart';
import 'package:jarvis/data/responses/ai_bot/get_assistant_response.dart';
import 'package:jarvis/data/responses/ai_bot/get_assistants_response.dart';
import 'package:jarvis/data/responses/ai_bot/update_assistant_response.dart';
import 'package:jarvis/data/responses/authentication_kb/knowledge_auth_response.dart';
import 'package:retrofit/retrofit.dart';
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
  Future<void> deleteAssistant(@Path("{${ConstantPath.assistantId}}") String assistantId);

  @PATCH(ConstantAPI.updateAssistant)
  Future<UpdateAssistantResponse> updateAssistant(
    @Path("{${ConstantPath.assistantId}}") String assistantId,
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
  Future<GetAssistantResponse> getAssistant(@Path("{${ConstantPath.assistantId}}") String assistandId);

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
}


class CreateAssistantRequest {
}

