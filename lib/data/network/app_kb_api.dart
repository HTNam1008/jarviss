import 'package:dio/dio.dart';
import 'package:jarvis/app/constant.dart';
import 'package:jarvis/data/request/ai_bot/ask_assistant_request.dart';
import 'package:jarvis/data/request/ai_bot/create_assistant_request.dart';
import 'package:jarvis/data/request/ai_bot/update_assistant_new_thread_playground_request.dart';
import 'package:jarvis/data/request/ai_bot/update_assistant_request.dart';
import 'package:jarvis/data/request/authentication_kb/knowledge_auth_request.dart';
import 'package:jarvis/data/responses/ai_bot/create_assistant_response.dart';
import 'package:jarvis/data/responses/ai_bot/get_assistant_response.dart';
import 'package:jarvis/data/responses/ai_bot/get_assistants_response.dart';
import 'package:jarvis/data/responses/ai_bot/retrieve_message_thread_response.dart';
import 'package:jarvis/data/responses/ai_bot/update_assistant_new_thread_playground_response.dart';
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
}