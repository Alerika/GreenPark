import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class ParkModel {
  String description;
  Double latitude;
  Double longitude;
  Int numberParking;

  ParkModel(
      {required this.description,
      required this.latitude,
      required this.longitude,
      required this.numberParking});

  //  json in object
  // ParkModel parkModel = ParkModel.fromJson(jsonDecode(objText));
  static ParkModel fromJson(Map<String, dynamic> json) => ParkModel(
      description: json['description'] as String,
      latitude: json['latitude'] as Double,
      longitude: json['longitude'] as Double,
      numberParking: json['numberParking'] as Int);

  @override
  String toString() {
    return 'ParkModel{description: $description, latitude: $latitude, longitude: $longitude, numberParking: $numberParking}';
  }
}
