import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/ReservedParkModel.dart';

class ReservedPark {
  //create
  Future createReservedParking({required ReservedParkModel parkModel}) async {
    //reference to document
    final docReservedParking =
        FirebaseFirestore.instance.collection('reservedCarPark').doc();

    final jsonReservedCarPark = parkModel.toJson(docReservedParking.id);
    //Create document and write date to firebase
    await docReservedParking.set(jsonReservedCarPark);
  }

  //read park list
  Stream<List<ReservedParkModel>> readReservedParking() =>
      FirebaseFirestore.instance.collection('reservedCarPark').snapshots().map(
          (snapshots) => snapshots.docs
              .map((doc) => ReservedParkModel.fromJson(doc.data()))
              .toList());

//read single park
  Future<ReservedParkModel?> readPark() async {
    final docPark =
        FirebaseFirestore.instance.collection('reservedCarPark').doc();
    final snapshot = await docPark.get();
    if (snapshot.exists) {
      return ReservedParkModel.fromJson(snapshot.data()!);
    }
    return null;
  }

  Widget buildParking(ReservedParkModel parkModel) => ListTile(
        leading: CircleAvatar(child: Text('${parkModel.description}')),
      );

  ReservedPark();

//update/delete use final doc = ...collection('park').doc('id');
//for specific fields
//doc.user.update({'field':'change',});
//doc.delete()
}
