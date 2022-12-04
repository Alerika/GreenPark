import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class ParkModel {
  String description;
  double latitude;
  double longitude;
  int numberParking;
  String id;

  ParkModel(
      {required this.description,
      required this.latitude,
      required this.longitude,
      required this.numberParking,
      required this.id});

  //  json in object
  // ParkModel parkModel = ParkModel.fromJson(jsonDecode(objText));
  static ParkModel fromJson(Map<String, dynamic> json) => ParkModel(
      description: json['description'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      numberParking: json['numberParking'] as int,
      id: json['id'] as String);

  @override
  String toString() {
    return 'ParkModel{description: $description, latitude: $latitude, longitude: $longitude, numberParking: $numberParking, id: $id}';
  }
}
