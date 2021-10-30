// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatMessage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) {
  return ChatMessage(
    imgUrl: json['imgUrl'] as String,
    message: json['message'] as String,
    sendBy: json['sendBy'] as String,
    ts: const TimestampConverter().fromJson(json['ts'] as Timestamp),
  );
}

Map<String, dynamic> _$ChatMessageToJson(ChatMessage instance) =>
    <String, dynamic>{
      'imgUrl': instance.imgUrl,
      'message': instance.message,
      'sendBy': instance.sendBy,
      'ts': const TimestampConverter().toJson(instance.ts),
    };
