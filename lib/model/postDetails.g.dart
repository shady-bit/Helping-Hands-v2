// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'postDetails.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostDetails _$PostDetailsFromJson(Map<String, dynamic> json) {
  return PostDetails(
    active: json['active'] as bool,
    bloodRequiredDateTime: const TimestampConverter()
        .fromJson(json['bloodRequiredDateTime'] as Timestamp),
    bloodRequiredDateTimeFirst: const TimestampConverter()
        .fromJson(json['bloodRequiredDateTimeFirst'] as Timestamp),
    createdBy: json['createdBy'] as String?,
    createdTime: json['createdTime'],
    expired: json['expired'] as bool,
    gender: json['gender'] as String,
    hospitalAddr: json['hospitalAddr'] as String,
    hospitalArea: json['hospitalArea'] as String,
    hospitalCity: json['hospitalCity'] as String,
    hospitalLocation: const GeopointConverter()
        .fromJson(json['hospitalLocation'] as Map<String, dynamic>),
    hospitalName: json['hospitalName'] as String,
    hospitalRoomNo: json['hospitalRoomNo'] as String,
    otherDetails: json['otherDetails'] as String?,
    patientAge: json['patientAge'] as String,
    patientAttenderContact1: json['patientAttenderContact1'] as String,
    patientAttenderContact2: json['patientAttenderContact2'] as String?,
    patientAttenderContact3: json['patientAttenderContact3'] as String?,
    patientAttenderName1: json['patientAttenderName1'] as String,
    patientAttenderName2: json['patientAttenderName2'] as String?,
    requiredBloodGrp: json['requiredBloodGrp'] as String,
    requiredUnits: json['requiredUnits'] as String,
    patientAttenderName3: json['patientAttenderName3'] as String?,
    patientName: json['patientName'] as String,
    purpose: json['purpose'] as String,
    requirementType: json['requirementType'] as String,
  )..id = json['id'] as String?;
}

Map<String, dynamic> _$PostDetailsToJson(PostDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'active': instance.active,
      'bloodRequiredDateTime':
          const TimestampConverter().toJson(instance.bloodRequiredDateTime),
      'bloodRequiredDateTimeFirst': const TimestampConverter()
          .toJson(instance.bloodRequiredDateTimeFirst),
      'createdBy': instance.createdBy,
      'createdTime': instance.createdTime,
      'expired': instance.expired,
      'gender': instance.gender,
      'hospitalAddr': instance.hospitalAddr,
      'hospitalArea': instance.hospitalArea,
      'hospitalCity': instance.hospitalCity,
      'hospitalLocation':
          const GeopointConverter().toJson(instance.hospitalLocation),
      'hospitalName': instance.hospitalName,
      'hospitalRoomNo': instance.hospitalRoomNo,
      'otherDetails': instance.otherDetails,
      'patientAge': instance.patientAge,
      'patientAttenderContact1': instance.patientAttenderContact1,
      'patientAttenderContact2': instance.patientAttenderContact2,
      'patientAttenderContact3': instance.patientAttenderContact3,
      'patientAttenderName1': instance.patientAttenderName1,
      'patientAttenderName2': instance.patientAttenderName2,
      'patientAttenderName3': instance.patientAttenderName3,
      'patientName': instance.patientName,
      'purpose': instance.purpose,
      'requiredBloodGrp': instance.requiredBloodGrp,
      'requiredUnits': instance.requiredUnits,
      'requirementType': instance.requirementType,
    };
