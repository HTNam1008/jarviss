import 'package:jarvis/data/network/app_api.dart';
import 'package:jarvis/data/request/request.dart';
import 'package:jarvis/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<SignInResponse> signIn(SignInRequest signInRequest);
  Future<SignUpResponse> signUp(SignUpRequest signUpRequest);
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
}
