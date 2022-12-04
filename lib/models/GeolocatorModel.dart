import 'dart:ffi';

class Geolocator {
  Double? latitude;
  Double? longitude;
  String? description;
  Int? numberParking;

  //constructor
  Geolocator(
      {required this.latitude,
      required this.longitude,
      required this.description,
      required this.numberParking});

  // we need to create map
  Geolocator.fromJson(Map<String, dynamic> json) {
    latitude = json["latitude"];
    longitude = json["longitude"];
    latitude = json["description"];
    longitude = json["numberParking"];
  }

  Map<String, dynamic> toJson() {
    // object - data
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data["description"] = this.description;
    data["numberParking"] = this.numberParking;

    return data;
  }
}
