import 'package:json_annotation/json_annotation.dart';

part 'responses.g.dart';

@JsonSerializable()
class UserResponse {
  final String email;
  final String password;
  final String username;
  final bool isActive;
  final List<String> usedAuthOptions;
  final List<String> roles;
  final String? createdBy;
  final String? updatedBy;
  final String? hashedRefreshToken;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final String id;

  UserResponse({
    required this.email,
    required this.password,
    required this.username,
    required this.isActive,
    required this.usedAuthOptions,
    required this.roles,
    this.createdBy,
    this.updatedBy,
    this.hashedRefreshToken,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.id,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}

@JsonSerializable()
class SignUpResponse {
  final UserResponse user;

  SignUpResponse({required this.user});

  factory SignUpResponse.fromJson(Map<String, dynamic> json) =>
      _$SignUpResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpResponseToJson(this);
}

@JsonSerializable()
class TokenResponse {
  final String accessToken;
  final String refreshToken;

  TokenResponse({
    required this.accessToken,
    required this.refreshToken,
  });

  factory TokenResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TokenResponseToJson(this);
}

@JsonSerializable()
class SignInResponse {
  final TokenResponse token;

  SignInResponse({required this.token});

  factory SignInResponse.fromJson(Map<String, dynamic> json) =>
      _$SignInResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignInResponseToJson(this);
}

@JsonSerializable()
class SignOutResponse {
  SignOutResponse();
  
  factory SignOutResponse.fromJson(Map<String, dynamic> json) =>
      _$SignOutResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignOutResponseToJson(this);
}

@JsonSerializable()
class RefreshTokenResponse {
  final TokenResponse newToken;

  RefreshTokenResponse({required this.newToken});

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenResponseToJson(this);
}
