// app_api.dart

import 'package:dio/dio.dart';
import 'package:jarvis/app/constant.dart';
import 'package:jarvis/data/responses/responses.dart';
import 'package:jarvis/data/request/request.dart';
import 'package:retrofit/retrofit.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;
  
  @POST("/api/v1/auth/sign-in")
  Future<SignInResponse> signIn(
    @Body() SignInRequest request,
  );

  @POST("/api/v1/auth/sign-up")
  Future<SignUpResponse> signUp(
    @Body() SignUpRequest request,
  );
}
