// lib/app/di/di.dart

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:jarvis/app/app_prefs.dart';
import 'package:jarvis/data/data_source/remote_data_source.dart';
import 'package:jarvis/data/network/app_api.dart';
import 'package:jarvis/data/network/app_kb_api.dart';
import 'package:jarvis/data/network/dio_factory.dart';
import 'package:jarvis/data/network/network_info.dart';
import 'package:jarvis/data/repository/repository_impl.dart';
import 'package:jarvis/domain/repository/repository.dart';
import 'package:jarvis/domain/usecase/create_email_reply_usecase.dart';
import 'package:jarvis/domain/usecase/create_knowledge_usecase.dart';
import 'package:jarvis/domain/usecase/delete_knowledge_usecase.dart';
import 'package:jarvis/domain/usecase/ask_assistant_usecase.dart';
import 'package:jarvis/domain/usecase/create_assistant_usecase.dart';
import 'package:jarvis/domain/usecase/create_thread_usecase.dart';
import 'package:jarvis/domain/usecase/delete_assistant_usecase.dart';
import 'package:jarvis/domain/usecase/disconnect_bot_integration_usecase.dart';
import 'package:jarvis/domain/usecase/get_assistant_usecase.dart';
import 'package:jarvis/domain/usecase/get_assistants_usecase.dart';
import 'package:jarvis/domain/usecase/get_configurations_usecase.dart';
import 'package:jarvis/domain/usecase/get_conversation_history_usecase.dart';
import 'package:jarvis/domain/usecase/get_conversations_usecase.dart';
import 'package:jarvis/domain/usecase/create_prompt_usecase.dart';
import 'package:jarvis/domain/usecase/get_knowledge_usecase.dart';
import 'package:jarvis/domain/usecase/get_units_usecase.dart';
import 'package:jarvis/domain/usecase/publish_messenger_bot_integration_usecase.dart';
import 'package:jarvis/domain/usecase/publish_slack_bot_integration_usecase.dart';
import 'package:jarvis/domain/usecase/publish_telegram_bot_integration_usecase.dart';
import 'package:jarvis/domain/usecase/refresh_token_usecase.dart';
import 'package:jarvis/domain/usecase/retrieve_message_thread_usecase.dart';
import 'package:jarvis/domain/usecase/send_message_usecase.dart';
import 'package:jarvis/domain/usecase/sign_in_kb_usecase.dart';
import 'package:jarvis/domain/usecase/sign_in_usecase.dart';
import 'package:jarvis/domain/usecase/sign_out_usecase.dart';
import 'package:jarvis/domain/usecase/sign_up_usecase.dart';
import 'package:jarvis/domain/usecase/update_knowledge_usecase.dart';
import 'package:jarvis/domain/usecase/upload_confluence_file_usecase.dart';
import 'package:jarvis/domain/usecase/upload_slack_file_usecase.dart';
import 'package:jarvis/domain/usecase/upload_web_file_usecase.dart';
import 'package:jarvis/domain/usecase/update_assistant_new_thread_playground_usecase.dart';
import 'package:jarvis/domain/usecase/update_assistant_usecase.dart';
import 'package:jarvis/domain/usecase/usage_token_usecase.dart';
import 'package:jarvis/domain/usecase/verify_messenger_bot_integration_usecase.dart';
import 'package:jarvis/domain/usecase/verify_slack_bot_integration_usecase.dart';
import 'package:jarvis/domain/usecase/verify_telegram_bot_integration_usecase.dart';
import 'package:jarvis/presentation/authencation/sign_in/sign_in_viewmodel.dart';
import 'package:jarvis/presentation/authencation/sign_out/sign_out_viewmodel.dart';
import 'package:jarvis/presentation/authencation/sign_up/sign_up_viewmodel.dart';
import 'package:jarvis/presentation/chat/chat_viewmodel.dart';
import 'package:jarvis/presentation/chatbot/create_bot/create_bot_viewmodel.dart';
import 'package:jarvis/presentation/chatbot/edit_bot/edit_bot_viewmodel.dart';
import 'package:jarvis/presentation/chatbot/main_chatbot_viewmodel.dart';
import 'package:jarvis/presentation/chatbot/preview_bot/preview_bot_viewmodel.dart';
import 'package:jarvis/presentation/email/email_view.dart';
import 'package:jarvis/presentation/left_side_bar/app_drawer_viewmodel.dart';
import 'package:jarvis/presentation/main/sign_in_kb_viewmodel.dart';
import 'package:jarvis/presentation/publish_bot/configure/configure_viewmodel.dart';
import 'package:jarvis/presentation/publish_bot/publish_bot_viewmodel.dart';
import 'package:jarvis/presentation/splash/splash_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repository/prompt_repository_impl.dart';
import '../../domain/repository/prompt_repository.dart';
import '../../domain/usecase/create_response_email_usecase.dart';
import '../../domain/usecase/delete_prompt_usecase.dart';
import '../../domain/usecase/get_public_prompts_usecase.dart';
import '../../domain/usecase/update _prompt_usecase.dart';
import '../../domain/usecase/upload_local_file_usecase.dart';
import '../../presentation/knowledge/knowledge_view.dart';
import '../../presentation/prompt/main_prompt_view.dart';
import '../../presentation/unit_add/unit_view_model.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // Register SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  // Đăng ký FlutterSecureStorage
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  // Register AppPreferences
  getIt.registerLazySingleton<AppPreferences>(() => AppPreferences(getIt<SharedPreferences>(), getIt<FlutterSecureStorage>()));

  // Register DioFactory
  getIt.registerLazySingleton<DioFactory>(() => DioFactory(getIt<AppPreferences>()));

  // Register Dio
  getIt.registerLazySingleton<Dio>(() => getIt<DioFactory>().getDio());

  // Register AppServiceClient
  getIt.registerLazySingleton<AppServiceClient>(
    () => AppServiceClient(getIt<Dio>()),
  );

  getIt.registerLazySingleton<AppKbServiceClient>(
    () => AppKbServiceClient(getIt<Dio>()),
  );

  // Register InternetConnectionChecker
  getIt.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker(),
  );

  // Register NetworkInfo
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(getIt<InternetConnectionChecker>()),
  );

  // Register RemoteDataSource
  getIt.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImplementer(getIt<AppServiceClient>(), getIt<AppKbServiceClient>()),
  );

  // Register Repository
  getIt.registerLazySingleton<Repository>(
    () => RepositoryImpl(getIt<RemoteDataSource>(), getIt<NetworkInfo>()),
  );

  // Register UseCases
  getIt.registerFactory<SignInUseCase>(
    () => SignInUseCase(getIt<Repository>()),
  );

  getIt.registerFactory<SignUpUseCase>(
    () => SignUpUseCase(getIt<Repository>()),
  );

  getIt.registerFactory<RefreshTokenUseCase>(
    () => RefreshTokenUseCase(getIt<Repository>()),
  );

  getIt.registerFactory<SignOutUseCase>(
    () => SignOutUseCase(getIt<Repository>()),
  );

  // Register ViewModels
  getIt.registerFactory<SignInViewModel>(
    () => SignInViewModel(getIt<SignInUseCase>(), getIt<AppPreferences>()),
  );

  getIt.registerFactory<SignUpViewModel>(
    () => SignUpViewModel(getIt<SignUpUseCase>(), getIt<AppPreferences>()),
  );

  getIt.registerFactory<SignOutViewModel>(
    () => SignOutViewModel(
      getIt<SignOutUseCase>(),
      getIt<AppPreferences>(),
    ),
  );

  getIt.registerLazySingleton<SendMessageUseCase>(
    () => SendMessageUseCase(getIt<Repository>()),
  );

  getIt.registerLazySingleton<PromptRepository>(
    () => PromptRepositoryImpl(getIt<RemoteDataSource>(), getIt<NetworkInfo>()),
  );

  getIt.registerFactory<GetPublicPromptsUseCase>(
    () => GetPublicPromptsUseCase(getIt<PromptRepository>()),
  );

  getIt.registerFactory<GetPrivatePromptsUseCase>(
    () => GetPrivatePromptsUseCase(getIt<PromptRepository>()),
  );

  getIt.registerFactory<PromptViewModel>(
    () => PromptViewModel(getIt<GetPublicPromptsUseCase>(), getIt<AddPromptToFavoriteUseCase>(), getIt<CreatePromptUseCase>(),
        getIt<GetPrivatePromptsUseCase>(), getIt<UpdatePromptUseCase>(), getIt<DeletePromptUseCase>()),
  );
  getIt.registerFactory<AddPromptToFavoriteUseCase>(
    () => AddPromptToFavoriteUseCase(getIt<PromptRepository>()),
  );
  getIt.registerFactory<CreatePromptUseCase>(
    () => CreatePromptUseCase(getIt<PromptRepository>()),
  );

  getIt.registerFactory<DeletePromptUseCase>(
    () => DeletePromptUseCase(getIt<PromptRepository>()),
  );

  getIt.registerFactory<UpdatePromptUseCase>(
    () => UpdatePromptUseCase(getIt<PromptRepository>()),
  );

  getIt.registerFactory<UsageTokenUseCase>(
    () => UsageTokenUseCase(getIt<Repository>()),
  );

  getIt.registerFactory<GetConversationHistoryUsecase>(
    () => GetConversationHistoryUsecase(getIt<Repository>()),
  );

  getIt.registerFactory<CreateThreadUseCase>(
    () => CreateThreadUseCase(getIt<Repository>()),
  );

  getIt.registerFactory<ChatViewModel>(
    () => ChatViewModel(getIt<SendMessageUseCase>(), getIt<UsageTokenUseCase>(), getIt<GetConversationHistoryUsecase>(), getIt<GetAssistantsUseCase>(),
        getIt<CreateThreadUseCase>(), getIt<AskAssistantUseCase>()),
  );

  getIt.registerFactory<SplashViewModel>(
    () => SplashViewModel(getIt<AppPreferences>(), getIt<SignInKbUseCase>()),
  );

  getIt.registerLazySingleton<GetConversationsUsecase>(
    () => GetConversationsUsecase(getIt<Repository>()),
  );

  getIt.registerLazySingleton<AppDrawerViewModel>(
    () => AppDrawerViewModel(getIt<GetConversationsUsecase>()),
  );

  // Register SignInKbUseCase
  getIt.registerFactory<SignInKbUseCase>(
    () => SignInKbUseCase(getIt<Repository>()),
  );

  // Register SignInKbViewModel
  getIt.registerFactory<SignInKbViewModel>(
    () => SignInKbViewModel(
      getIt<SignInKbUseCase>(),
      getIt<AppPreferences>(),
    ),
  );

  getIt.registerFactory<GetAssistantsUseCase>(
    () => GetAssistantsUseCase(getIt<Repository>()),
  );

  getIt.registerFactory<GetAssistantUseCase>(
    () => GetAssistantUseCase(getIt<Repository>()),
  );

  getIt.registerFactory<MainChatbotViewModel>(
    () => MainChatbotViewModel(getIt<GetAssistantsUseCase>(), getIt<DeleteAssistantUseCase>()),
  );

  getIt.registerFactory<CreateAssistantUseCase>(
    () => CreateAssistantUseCase(getIt<Repository>()),
  );

  getIt.registerFactory<CreateBotViewModel>(
    () => CreateBotViewModel(getIt<CreateAssistantUseCase>()),
  );

  getIt.registerFactory<UpdateAssistantUseCase>(
    () => UpdateAssistantUseCase(getIt<Repository>()),
  );

  getIt.registerLazySingleton<GetKnowledgeUsecase>(() => GetKnowledgeUsecase(getIt<Repository>()));
  
  getIt.registerFactory<CreateKnowledgeUsecase>(
        () => CreateKnowledgeUsecase(getIt<Repository>()),
  );
  getIt.registerFactory<UpdateKnowledgeUseCase>(
        () => UpdateKnowledgeUseCase(getIt<Repository>()),
  );
  getIt.registerFactory<DeleteKnowledgeUsecase>(
        () => DeleteKnowledgeUsecase(getIt<Repository>()),
  );
  getIt.registerFactory<KnowledgeViewModel>(() => KnowledgeViewModel(getIt<GetKnowledgeUsecase>(),getIt<CreateKnowledgeUsecase>(),getIt<UpdateKnowledgeUseCase>(),getIt<DeleteKnowledgeUsecase>()));
  getIt.registerFactory<UploadLocalFileUsecase>(
        () => UploadLocalFileUsecase(getIt<Repository>()),
  );
  getIt.registerFactory<UploadWebFileUsecase>(
        () => UploadWebFileUsecase(getIt<Repository>()),
  );
  getIt.registerFactory<UploadSlackFileUsecase>(
        () => UploadSlackFileUsecase(getIt<Repository>()),
  );
  getIt.registerFactory<UploadConfluenceFileUsecase>(
        () => UploadConfluenceFileUsecase(getIt<Repository>()),
  );
  getIt.registerLazySingleton<GetUnitsUsecase>(() => GetUnitsUsecase(getIt<Repository>()));

  getIt.registerFactory<UnitViewModel>(
        () => UnitViewModel(getIt<UploadLocalFileUsecase>(),getIt<UploadWebFileUsecase>(), getIt<UploadSlackFileUsecase>(),getIt<UploadConfluenceFileUsecase>(),getIt<GetUnitsUsecase>()),
  );

  getIt.registerFactory<CreateEmailReplyUsecase>(
        () => CreateEmailReplyUsecase(getIt<Repository>()),
  );

  getIt.registerFactory<CreateResponseEmailUsecase>(
        () => CreateResponseEmailUsecase(getIt<Repository>()),
  );

  getIt.registerFactory<EmailViewModel>(
        () => EmailViewModel(getIt<CreateEmailReplyUsecase>(), getIt<CreateResponseEmailUsecase>()),
  );
  
  getIt.registerFactory<EditBotViewModel>(
    () => EditBotViewModel(
      getIt<UpdateAssistantUseCase>(), 
      getIt<GetAssistantUseCase>()
      ),
  );

  getIt.registerFactory<DeleteAssistantUseCase>(
    () => DeleteAssistantUseCase(getIt<Repository>()),
  );

  getIt.registerFactory<AskAssistantUseCase>(
    () => AskAssistantUseCase(getIt<Repository>()),
  );

  getIt.registerFactory<UpdateAssistantNewThreadPlayGroundUseCase>(
    () => UpdateAssistantNewThreadPlayGroundUseCase(getIt<Repository>()),
  );

  getIt.registerFactory<PreviewBotViewModel>(
    () => PreviewBotViewModel(getIt<AskAssistantUseCase>(), getIt<RetrieveMessageThreadUseCase>(), getIt<UpdateAssistantNewThreadPlayGroundUseCase>()),
  );

  getIt.registerFactory<RetrieveMessageThreadUseCase>(
    () => RetrieveMessageThreadUseCase(getIt<Repository>()),
  );

  getIt.registerFactory<GetConfigurationsUseCase>(
    () => GetConfigurationsUseCase(getIt<Repository>()),
  );

  getIt.registerFactory<PublishMessengerBotIntegrationUsecase>(
    () => PublishMessengerBotIntegrationUsecase(getIt<Repository>()),
  );

  getIt.registerFactory<PublishSlackBotIntegrationUsecase>(
    () => PublishSlackBotIntegrationUsecase(getIt<Repository>()),
  );

  getIt.registerFactory<PublishTelegramBotIntegrationUsecase>(
    () => PublishTelegramBotIntegrationUsecase(getIt<Repository>()),
  );

  getIt.registerFactory<PublishBotViewModel>(
    () => PublishBotViewModel(getIt<GetConfigurationsUseCase>(), getIt<PublishMessengerBotIntegrationUsecase>(), getIt<PublishSlackBotIntegrationUsecase>(),
        getIt<PublishTelegramBotIntegrationUsecase>()),
  );

  getIt.registerFactory<VerifyMessengerBotIntegrationUsecase>(
    () => VerifyMessengerBotIntegrationUsecase(getIt<Repository>()),
  );

  getIt.registerFactory<VerifySlackBotIntegrationUsecase>(
    () => VerifySlackBotIntegrationUsecase(getIt<Repository>()),
  );

  getIt.registerFactory<VerifyTelegramBotIntegrationUsecase>(
    () => VerifyTelegramBotIntegrationUsecase(getIt<Repository>()),
  );

  getIt.registerFactory<DisconnectBotIntegrationUsecase>(
    () => DisconnectBotIntegrationUsecase(getIt<Repository>()),
  );
  

  getIt.registerFactory<ConfigureViewModel>(
    () => ConfigureViewModel(
      getIt<VerifySlackBotIntegrationUsecase>(),
      getIt<VerifyTelegramBotIntegrationUsecase>(),
      getIt<VerifyMessengerBotIntegrationUsecase>(),
      getIt<DisconnectBotIntegrationUsecase>(),
    ),
  );
}
