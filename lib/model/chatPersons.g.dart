// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatPersons.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatPersons _$ChatPersonsFromJson(Map<String, dynamic> json) {
  return ChatPersons(
    lastMessage: json['lastMessage'] as String,
    lastMessageSendBy: json['lastMessageSendBy'] as String,
    lastMessageSendTs: const TimestampConverter()
        .fromJson(json['lastMessageSendTs'] as Timestamp),
    users: (json['users'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$ChatPersonsToJson(ChatPersons instance) =>
    <String, dynamic>{
      'lastMessage': instance.lastMessage,
      'lastMessageSendBy': instance.lastMessageSendBy,
      'lastMessageSendTs':
          const TimestampConverter().toJson(instance.lastMessageSendTs),
      'users': instance.users,
    };
