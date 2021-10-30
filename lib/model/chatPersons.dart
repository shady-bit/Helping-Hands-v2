import 'package:cloud_firestore/cloud_firestore.dart';

import 'customJsonConverter/TimestampConverter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'chatPersons.g.dart';


@JsonSerializable()
class ChatPersons {
  String lastMessage;
  String lastMessageSendBy;
  @TimestampConverter()
  DateTime lastMessageSendTs;
  List<String> users;

  
  ChatPersons({required this.lastMessage,required this.lastMessageSendBy,required this.lastMessageSendTs,required this.users});
   factory ChatPersons.fromJson(Map<String, dynamic> json) =>
      _$ChatPersonsFromJson(json);
  Map<String, dynamic> toJson() => _$ChatPersonsToJson(this);
}
