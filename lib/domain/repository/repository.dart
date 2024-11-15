import 'package:dartz/dartz.dart';
import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/domain/model/model.dart';
import 'package:jarvis/data/request/request.dart';

abstract class Repository {
  Future<Either<Failure, Token>> signIn(SignInRequest signInRequest);
  Future<Either<Failure, User>> signUp(SignUpRequest signUpRequest);
}
