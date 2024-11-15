import 'package:freezed_annotation/freezed_annotation.dart';

part 'freezed_data_classes.freezed.dart';

@freezed
class SignInObject with _$SignInObject {
  const factory SignInObject({
    required String email,
    required String password,
  }) = _SignInObject;
}

@freezed
class SignUpObject with _$SignUpObject {
  const factory SignUpObject({
    required String email,
    required String password,
    required String username,
  }) = _SignUpObject;
}

