import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'customJsonConverter/GeopointConverter.dart';
import 'customJsonConverter/TimestampConverter.dart';
part 'profile.g.dart';


@JsonSerializable()
class Profile {
  String name;
  String email;
  String deviceToken;
  String bloodGrp;
  String phone;
  String profilePic;
  String referralCode;
  String uid;
  String userAddress;
  int lifePoints;
  String emergency1;
  String emergency2;
  @TimestampConverter()
  DateTime dob;
  String? friend;
  bool donateBlood;
  bool donatePlasma;
  bool donatePlatlets;
  @TimestampConverter()
  DateTime? lastDonated;
  @TimestampConverter()
  DateTime? lastPlasmaDonated;
  @TimestampConverter()
  DateTime? lastPlateletsDonated;
  dynamic lastOpened;
  @GeopointConverter()
  LatLng latLng;


  Profile({
    required this.name,
    required this.email,
    required this.bloodGrp,
    required this.deviceToken,
    required this.dob,
    required this.emergency1,
    required this.emergency2,
    required this.lifePoints,
    required this.phone,
    required this.profilePic,
    required this.referralCode,
    required this.uid,
    required this.userAddress,
    this.friend,
    required this.donateBlood,
    required this.donatePlasma,
    required this.donatePlatlets,
    this.lastDonated,
    this.lastPlasmaDonated,
    this.lastPlateletsDonated,
    required this.lastOpened,
    required this.latLng,
  });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
