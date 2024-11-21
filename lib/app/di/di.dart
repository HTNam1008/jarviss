// lib/app/di/di.dart

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:jarvis/app/app_prefs.dart';
import 'package:jarvis/data/data_source/remote_data_source.dart';
import 'package:jarvis/data/network/app_api.dart';
import 'package:jarvis/data/network/auth_interceptor.dart';
import 'package:jarvis/data/network/dio_factory.dart';
import 'package:jarvis/data/network/network_info.dart';
import 'package:jarvis/data/repository/repository_impl.dart';
import 'package:jarvis/domain/repository/repository.dart';
import 'package:jarvis/domain/usecase/refresh_token_usecase.dart';
import 'package:jarvis/domain/usecase/send_message_usecase.dart';
import 'package:jarvis/domain/usecase/sign_in_usecase.dart';
import 'package:jarvis/domain/usecase/sign_out_usecase.dart';
import 'package:jarvis/domain/usecase/sign_up_usecase.dart';
import 'package:jarvis/presentation/authencation/sign_in/sign_in_viewmodel.dart';
import 'package:jarvis/presentation/authencation/sign_out/sign_out_viewmodel.dart';
import 'package:jarvis/presentation/authencation/sign_up/sign_up_viewmodel.dart';
import 'package:jarvis/presentation/chat/chat_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repository/prompt_repository_impl.dart';
import '../../domain/repository/prompt_repository.dart';
import '../../domain/usecase/get_public_prompts_usecase.dart';
import '../../presentation/prompt/main_prompt_view.dart';


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
  getIt.registerLazySingleton<AppPreferences>(
      () => AppPreferences(getIt<SharedPreferences>(), getIt<FlutterSecureStorage>()));

  // Register DioFactory
  getIt.registerLazySingleton<DioFactory>(
      () => DioFactory(getIt<AppPreferences>()));

  // Register Dio
  getIt.registerLazySingleton<Dio>(() => getIt<DioFactory>().getDio());

  // Register AppServiceClient
  getIt.registerLazySingleton<AppServiceClient>(
    () => AppServiceClient(getIt<Dio>()),
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
    () => RemoteDataSourceImplementer(getIt<AppServiceClient>()),
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

  getIt.registerLazySingleton<PromptRepository>(
        () => PromptRepositoryImpl(getIt<RemoteDataSource>(), getIt<NetworkInfo>()),
  );

  getIt.registerFactory<GetPublicPromptsUseCase>(
        () => GetPublicPromptsUseCase(getIt<PromptRepository>()),
  );

  getIt.registerFactory<PromptViewModel>(
        () => PromptViewModel(
      getIt<GetPublicPromptsUseCase>(),
      getIt<AddPromptToFavoriteUseCase>(),
    ),
  );
  getIt.registerFactory<AddPromptToFavoriteUseCase>(
        () => AddPromptToFavoriteUseCase(getIt<PromptRepository>()),
  );


  getIt.registerFactory<SendMessageUseCase>(
    () => SendMessageUseCase(getIt<Repository>()),
  );

  getIt.registerFactory<ChatViewModel>(
    () => ChatViewModel(getIt<SendMessageUseCase>()),
  );
}
