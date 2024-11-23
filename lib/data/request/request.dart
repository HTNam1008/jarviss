// request.dart

import 'package:json_annotation/json_annotation.dart';

part 'request.g.dart';

// @JsonSerializable()
// class SignInRequest {
//   final String email;
//   final String password;
//
//   SignInRequest({
//     required this.email,
//     required this.password,
//   });
//
//   factory SignInRequest.fromJson(Map<String, dynamic> json) =>
//       _$SignInRequestFromJson(json);
//
//   Map<String, dynamic> toJson() => _$SignInRequestToJson(this);
// }
//
// @JsonSerializable()
// class SignUpRequest {
//   final String email;
//   final String password;
//   final String username;
//
//   SignUpRequest({
//     required this.email,
//     required this.password,
//     required this.username,
//   });
//
//   factory SignUpRequest.fromJson(Map<String, dynamic> json) =>
//       _$SignUpRequestFromJson(json);
//
//   Map<String, dynamic> toJson() => _$SignUpRequestToJson(this);
// }

@JsonSerializable()
class RefreshTokenRequest {
  final String refreshToken;

  RefreshTokenRequest({required this.refreshToken});

  factory RefreshTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenRequestToJson(this);
}
@JsonSerializable()
class CreatePromptRequest {
  final String title;
  final String content;
  final String description;
  final String category;
  final String language;
  final bool isPublic;

  CreatePromptRequest({
    required this.title,
    required this.content,
    required this.description,
    required this.category,
    required this.language,
    required this.isPublic
  });

  factory CreatePromptRequest.fromJson(Map<String, dynamic> json) =>
      _$CreatePromptRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePromptRequestToJson(this);
}

@JsonSerializable()
class UpdatePromptRequest {
  final String? title;
  final String? content;
  final String description;
  final String category;
  final String language;
  final bool isPublic;

  UpdatePromptRequest({
    this.title,
    this.content,
    required this.description,
    required this.category,
    required this.language,
    required this.isPublic
  });

  factory UpdatePromptRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdatePromptRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdatePromptRequestToJson(this);
}