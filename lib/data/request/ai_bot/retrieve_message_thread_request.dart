// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'retrieve_message_thread_request.g.dart';

@JsonSerializable()
class RetrieveMessageThreadRequest {
  final String openAiThreadId;
  
  RetrieveMessageThreadRequest({
    required this.openAiThreadId,
  });
  
  factory RetrieveMessageThreadRequest.fromJson(Map<String, dynamic> json) =>
      _$RetrieveMessageThreadRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RetrieveMessageThreadRequestToJson(this);
}
