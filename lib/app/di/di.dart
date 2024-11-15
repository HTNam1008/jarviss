// lib/app/di/di.dart

import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:jarvis/app/app_prefs.dart';
import 'package:jarvis/data/data_source/remote_data_source.dart';
import 'package:jarvis/data/network/app_api.dart';
import 'package:jarvis/data/network/dio_factory.dart';
import 'package:jarvis/data/network/network_info.dart';
import 'package:jarvis/data/repository/repository_impl.dart';
import 'package:jarvis/domain/repository/repository.dart';
import 'package:jarvis/domain/usecase/login_usecase.dart';
import 'package:jarvis/presentation/login/login_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // Register SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // Register AppPreferences
  getIt.registerLazySingleton<AppPreferences>(
      () => AppPreferences(getIt<SharedPreferences>()));

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
  getIt.registerFactory<LoginUseCase>(
    () => LoginUseCase(getIt<Repository>()),
  );

  // Register LoginViewModels
  getIt.registerFactory<LoginViewModel>(
    () => LoginViewModel(getIt<LoginUseCase>(), getIt<AppPreferences>()),
  );
}
