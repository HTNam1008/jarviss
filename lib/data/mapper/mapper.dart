import 'package:jarvis/app/extensions.dart';
import 'package:jarvis/data/responses/responses.dart';
import 'package:jarvis/domain/model/model.dart';

const EMPTY = "";
const ZERO = 0;

extension UserResponseMapper on UserResponse {
  User toDomain() {
    return User(
      id: id.orEmpty(),
      email: email.orEmpty(),
      username: username.orEmpty(),
      isActive: isActive,
      roles: roles,
      createdAt: createdAt.orEmpty(),
      updatedAt: updatedAt.orEmpty(),
    );
  }
}

extension TokenResponseMapper on TokenResponse {
  Token toDomain() {
    return Token(
      accessToken: accessToken.orEmpty(),
      refreshToken: refreshToken.orEmpty(),
    );
  }
}

extension SignInResponseMapper on SignInResponse {
  Token toDomain() {
    return token.toDomain();
  }
}

extension SignUpResponseMapper on SignUpResponse {
  User toDomain() {
    return user.toDomain();
  }
}
