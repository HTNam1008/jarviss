import 'package:json_annotation/json_annotation.dart';

part 'create_email_reply_response.g.dart';  // This will generate the necessary code.

@JsonSerializable()
class CreateEmailReplyResponse {
  final List<String> ideas;

  CreateEmailReplyResponse({required this.ideas});

  // Factory constructor for creating a new `CreateEmailResponse` instance from JSON data
  factory CreateEmailReplyResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateEmailReplyResponseFromJson(json);

  // `toJson` method for converting an instance of `CreateEmailResponse` into JSON format
  Map<String, dynamic> toJson() => _$CreateEmailReplyResponseToJson(this);
}
