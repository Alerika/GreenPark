import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/ParkModel.dart';

class CarParkListViewList extends StatelessWidget {
  final db = FirebaseFirestore.instance;

  CarParkListViewList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

  Widget buildParking(ParkModel parkModel) => ListTile(
        leading: CircleAvatar(child: Text('${parkModel.description}')),
      );

  Stream<List<ParkModel>> readParking() => FirebaseFirestore.instance
      .collection('carParks')
      .snapshots()
      .map((snapshots) =>
          snapshots.docs.map((doc) => ParkModel.fromJson(doc.data())).toList());
}
