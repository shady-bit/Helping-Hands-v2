// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile(
    name: json['name'] as String,
    email: json['email'] as String,
    bloodGrp: json['bloodGrp'] as String,
    deviceToken: json['deviceToken'] as String,
    dob: const TimestampConverter().fromJson(json['dob'] as Timestamp),
    emergency1: json['emergency1'] as String,
    emergency2: json['emergency2'] as String,
    lifePoints: json['lifePoints'] as int,
    phone: json['phone'] as String,
    profilePic: json['profilePic'] as String,
    referralCode: json['referralCode'] as String,
    uid: json['uid'] as String,
    userAddress: json['userAddress'] as String,
    friend: json['friend'] as String?,
    donateBlood: json['donateBlood'] as bool,
    donatePlasma: json['donatePlasma'] as bool,
    donatePlatlets: json['donatePlatlets'] as bool,
    lastDonated: json['lastDonated'] == null
        ? null
        : DateTime.parse(json['lastDonated'] as String),
    lastPlasmaDonated: json['lastPlasmaDonated'] == null
        ? null
        : DateTime.parse(json['lastPlasmaDonated'] as String),
    lastPlateletsDonated: json['lastPlateletsDonated'] == null
        ? null
        : DateTime.parse(json['lastPlateletsDonated'] as String),
    lastOpened: json['lastOpened'],
    latLng: const GeopointConverter()
        .fromJson(json['latLng'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'deviceToken': instance.deviceToken,
      'bloodGrp': instance.bloodGrp,
      'phone': instance.phone,
      'profilePic': instance.profilePic,
      'referralCode': instance.referralCode,
      'uid': instance.uid,
      'userAddress': instance.userAddress,
      'lifePoints': instance.lifePoints,
      'emergency1': instance.emergency1,
      'emergency2': instance.emergency2,
      'dob': const TimestampConverter().toJson(instance.dob),
      'friend': instance.friend,
      'donateBlood': instance.donateBlood,
      'donatePlasma': instance.donatePlasma,
      'donatePlatlets': instance.donatePlatlets,
      'lastDonated': instance.lastDonated?.toIso8601String(),
      'lastPlasmaDonated': instance.lastPlasmaDonated?.toIso8601String(),
      'lastPlateletsDonated': instance.lastPlateletsDonated?.toIso8601String(),
      'lastOpened': instance.lastOpened,
      'latLng': const GeopointConverter().toJson(instance.latLng),
    };
