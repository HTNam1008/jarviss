import 'package:json_annotation/json_annotation.dart';

part 'create_email_reply_request.g.dart'; // This will generate the necessary code.

@JsonSerializable()
class CreateEmailReplyRequest {
  final String action;
  final String email;
  final Metadata metadata;

  CreateEmailReplyRequest({
    required this.action,
    required this.email,
    required this.metadata,
  });

  // Factory constructor for creating a new `CreateEmailReplyRequest` instance from JSON data
  factory CreateEmailReplyRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateEmailReplyRequestFromJson(json);

  // `toJson` method for converting an instance of `CreateEmailReplyRequest` into JSON format
  Map<String, dynamic> toJson() => _$CreateEmailReplyRequestToJson(this);
}

@JsonSerializable()
class Metadata {
  final List<String> context;
  final String subject;
  final String sender;
  final String receiver;
  final String language;

  Metadata({
    required this.context,
    required this.subject,
    required this.sender,
    required this.receiver,
    required this.language,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}
