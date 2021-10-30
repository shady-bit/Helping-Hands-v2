import 'package:cloud_firestore/cloud_firestore.dart';

import 'customJsonConverter/TimestampConverter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'chatMessage.g.dart';

@JsonSerializable()
class ChatMessage {
  String imgUrl;
  String message;
  String sendBy;
  @TimestampConverter()
  DateTime ts;

  ChatMessage(
      {required this.imgUrl,
      required this.message,
      required this.sendBy,
      required this.ts});
  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);
  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);
}
