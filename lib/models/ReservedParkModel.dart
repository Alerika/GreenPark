import 'package:cloud_firestore/cloud_firestore.dart';

class ReservedParkModel {
  String id;
  String user;
  String description;
  bool deletedOrExpired;
  bool reserved;
  double latitude;
  double longitude;
  DateTime timestampReserved;

  ReservedParkModel(
      {this.id = '',
      required this.user,
      required this.description,
      required this.deletedOrExpired,
      required this.reserved,
      required this.latitude,
      required this.longitude,
      required this.timestampReserved});

  //  json in object
  // ParkModel parkModel = ParkModel.fromJson(jsonDecode(objText));
  factory ReservedParkModel.fromJson(dynamic json) {
    return ReservedParkModel(
        id: json['id'] as String,
        user: json['user'] as String,
        description: json['description'] as String,
        deletedOrExpired: json['deletedOrExpired'] as bool,
        reserved: json['reserved'] as bool,
        latitude: json['latitude'] as double,
        longitude: json['longitude'] as double,
        timestampReserved: (json['timestampReserved'] as Timestamp).toDate());
  }

  // STRING to JSON
  // String jsonUser = jsonEncode(user);
  Map<String, dynamic> toJson(String id) => {
        'id': id,
        'user': user,
        'description': description,
        'deletedOrExpired': deletedOrExpired,
        'reserved': reserved,
        'latitude': latitude,
        'longitude': longitude,
        'timestampReserved': timestampReserved,
      };



  @override
  String toString() {
    return 'ReservedParkModel{user: $user, description: $description, deletedOrExpired: $deletedOrExpired, reserved: $reserved, latitude: $latitude, longitude: $longitude, timestampReserved: $timestampReserved}';
  }
}
