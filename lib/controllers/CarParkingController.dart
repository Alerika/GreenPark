import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:greenpark/models/ParkModel.dart';

class CarParkingController {

  //read park list
  Stream<List<ParkModel>> readParking() => FirebaseFirestore.instance
      .collection('carParks')
      .snapshots()
      .map((snapshots) =>
      snapshots.docs.map((doc) => ParkModel.fromJson(doc.data())).toList());

//read single park
  Future<ParkModel?> readPark() async {
    final docPark =
    FirebaseFirestore.instance.collection('carParks').doc();
    final snapshot = await docPark.get();
    if (snapshot.exists) {
      return ParkModel.fromJson(snapshot.data()!);
    }
    return null;
  }



//update/delete use final doc = ...collection('park').doc('id');
//for specific fields
//doc.user.update({'field':'change',});
//doc.delete()
}
