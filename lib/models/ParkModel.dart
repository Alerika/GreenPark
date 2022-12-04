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
      description: json['description'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      numberParking: json['numberParking'],
      id: json['id']);

  @override
  String toString() {
    return 'ParkModel{description: $description, latitude: $latitude, longitude: $longitude, numberParking: $numberParking, id: $id}';
  }
}
