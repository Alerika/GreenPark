import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/ParkModel.dart';
import '../models/ReservedParkModel.dart';

import '../pages/ParkSettingPage.dart';

class CarParkListViewList extends StatelessWidget {
  final db = FirebaseFirestore.instance;

  CarParkListViewList({Key? key}) : super(key: key);
  BuildContext? con;

  @override
  Widget build(BuildContext context) {
    con = context;
    return Scaffold(
      body: StreamBuilder<List<ParkModel>>(
        stream: readParking(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong! ${snapshot.error}');
          } else if (snapshot.hasData) {
            final parks = snapshot.data!;
            return ListView(
              children: parks.map(buildParking).toList(),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget buildParking(ParkModel parkModel) {
    String title = "still ${parkModel.numberParking} free parking";
    return Card(
        child: ListTile(
            title: Text(parkModel.description),
            subtitle: Text(title),
            trailing: const Icon(Icons.arrow_circle_right_outlined),
            onTap: () {
              Navigator.push(
                  con!,
                  MaterialPageRoute(
                    builder: (context) => ParkSettingPage(parkModel),
                  ));
            },
            leading: const CircleAvatar(
                child: Text('P'),
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                radius: 30)));
  }

  Stream<List<ParkModel>> readParking() => FirebaseFirestore.instance
      .collection('carParks')
      .snapshots()
      .map((snapshots) =>
          snapshots.docs.map((doc) => ParkModel.fromJson(doc.data())).toList());

  Stream<List<ReservedParkModel>> readReservedParking() => FirebaseFirestore.instance
      .collection('reservedCarPark')
      .snapshots()
      .map((snapshots) => snapshots.docs
          .map((doc) => ReservedParkModel.fromJson(doc.data()))
          .toList());
}
