import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';


class GeopointConverter implements JsonConverter<LatLng, Map<String, dynamic>> {
  const GeopointConverter();

  @override
  LatLng fromJson(Map<String, dynamic> locationData) {
    GeoPoint geoPoint = locationData["geopoint"];
    return LatLng(geoPoint.latitude, geoPoint.longitude);
  }

  @override
  Map<String, dynamic> toJson(LatLng latLng) {
    return GeoFirePoint(latLng.latitude, latLng.longitude).data;
  }
}