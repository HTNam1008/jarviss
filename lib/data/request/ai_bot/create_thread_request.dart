import 'package:json_annotation/json_annotation.dart';

part 'create_thread_request.g.dart';

@JsonSerializable()
class CreateThreadRequest {
  String assistantId;
  String? firstMessage;

  CreateThreadRequest({
    required this.assistantId,
    this.firstMessage,
  });

  factory CreateThreadRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateThreadRequestFromJson(json);
      
  Map<String, dynamic> toJson() => _$CreateThreadRequestToJson(this);
}
