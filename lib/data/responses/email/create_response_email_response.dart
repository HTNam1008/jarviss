import 'package:json_annotation/json_annotation.dart';

part 'create_response_email_response.g.dart';  // This will generate the necessary code.

@JsonSerializable()
class CreateResponseEmailResponse {
  final String email;
  final int remainingUsage;

  CreateResponseEmailResponse({
    required this.email,
    required this.remainingUsage,
  });

  // Factory constructor for creating a new `CreateEmailReplyResponse` instance from JSON data
  factory CreateResponseEmailResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateResponseEmailResponseFromJson(json);

  // `toJson` method for converting an instance of `CreateEmailReplyResponse` into JSON format
  Map<String, dynamic> toJson() => _$CreateResponseEmailResponseToJson(this);
}
