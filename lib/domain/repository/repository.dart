import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/data/network/failure.dart';
import 'package:flutter_application_1/data/request/request.dart';
import 'package:flutter_application_1/domain/model/model.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
}