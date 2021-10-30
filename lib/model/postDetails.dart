import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'customJsonConverter/GeopointConverter.dart';
import 'customJsonConverter/TimestampConverter.dart';
part 'postDetails.g.dart';

@JsonSerializable()
class PostDetails {
  String? id;
  bool active;
  @TimestampConverter()
  DateTime bloodRequiredDateTime;
  @TimestampConverter()
  DateTime bloodRequiredDateTimeFirst;
  String? createdBy;
  // @TimestampConverter()
  dynamic createdTime;
  bool expired;
  String gender;
  String hospitalAddr;
  String hospitalArea;
  String hospitalCity;
  @GeopointConverter()
  LatLng hospitalLocation;
  String hospitalName;
  String hospitalRoomNo;
  String? otherDetails;
  String patientAge;
  String patientAttenderContact1;
  String? patientAttenderContact2;
  String? patientAttenderContact3;
  String patientAttenderName1;
  String? patientAttenderName2;
  String? patientAttenderName3;
  String patientName;
  String purpose;
  String requiredBloodGrp;
  String requiredUnits;
  String requirementType;

  PostDetails(
      {required this.active,
      required this.bloodRequiredDateTime,
      required this.bloodRequiredDateTimeFirst,
       this.createdBy,
       this.createdTime,
      required this.expired,
      required this.gender,
      required this.hospitalAddr,
      required this.hospitalArea,
      required this.hospitalCity,
      required this.hospitalLocation,
      required this.hospitalName,
      required this.hospitalRoomNo,
      required this.otherDetails,
      required this.patientAge,
      required this.patientAttenderContact1,
      required this.patientAttenderContact2,
      required this.patientAttenderContact3,
      required this.patientAttenderName1,
      required this.patientAttenderName2,
      required this.requiredBloodGrp,
      required this.requiredUnits,
      required this.patientAttenderName3,
      required this.patientName,
      required this.purpose,
      required this.requirementType});

  factory PostDetails.fromJson(String _id, Map<String, dynamic> json) {
    return _$PostDetailsFromJson(json)..id = _id;
  }
  Map<String, dynamic> toJson({required bool update}){ 
  var json =    _$PostDetailsToJson(this);
  json.removeWhere((key, value) => key == 'id');
  if(update)
  {
    json.removeWhere((key, value) => (key == 'bloodRequiredDateTimeFirst' || key == "createdBy" || key == "createdTime" ));
  }
  return json;

   }
}
