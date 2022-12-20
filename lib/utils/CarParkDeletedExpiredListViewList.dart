import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/ParkModel.dart';
import '../models/ReservedParkModel.dart';

import '../pages/ParkSettingPage.dart';

class CarParkDeletedExpiredListViewList extends StatefulWidget {
  CarParkDeletedExpiredListViewList({Key? key}) : super(key: key);
  final db = FirebaseFirestore.instance;

  @override
  State<CarParkDeletedExpiredListViewList> createState() =>
      _CarParkListViewListState();

  Stream<List<ParkModel>> readParking() => FirebaseFirestore.instance
      .collection('carParks')
      .snapshots()
      .map((snapshots) =>
          snapshots.docs.map((doc) => ParkModel.fromJson(doc.data())).toList());

  Stream<List<ReservedParkModel>> readReservedParking() =>
      FirebaseFirestore.instance.collection('reservedCarPark').snapshots().map(
          (snapshots) => snapshots.docs
              .map((doc) => ReservedParkModel.fromJson(doc.data()))
              .toList());
}

class _CarParkListViewListState
    extends State<CarParkDeletedExpiredListViewList> {
  _CarParkListViewListState();

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<ReservedParkModel>>(
        stream: CarParkDeletedExpiredListViewList().readReservedParking(),
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

  Widget buildParking(ReservedParkModel parkModel) {
    final DateTime end = DateTime.now();
    final Duration duration = end.difference(parkModel.timestampReserved);
    final docReservedPark = FirebaseFirestore.instance
        .collection('reservedCarPark')
        .doc(parkModel.id);
    if (parkModel.deletedOrExpired == false && duration.inMinutes > 30) {
      docReservedPark.update({
        'deletedOrExpired': true,
      });
    }
    if (parkModel.user == user.email && (parkModel.deletedOrExpired == true)) {
      return Card(
          child: ListTile(
              title: Text(parkModel.description),
              subtitle: const Text("deleted or expired"),
              trailing: const Icon(Icons.arrow_circle_right_outlined),
              onTap: () {
                // Navigate to Next Details
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => parkSettingPage(parkModel),
                    ));
              },
              leading: const CircleAvatar(
                  child: Text('P'),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  radius: 30)));
    }
    return const SizedBox();
  }

  Widget parkSettingPage(ReservedParkModel parkModel) {
    return Scaffold(
        appBar: AppBar(
          title: Text(parkModel.description),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                const CircleAvatar(
                  radius: 150,
                  child: CircleAvatar(
                    radius: 150,
                    backgroundImage: AssetImage('logo_circular.png'),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  parkModel.description,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '   Latitude: ${parkModel.latitude}\n   Longitude: ${parkModel.longitude}\n   Reserved in date: ${parkModel.timestampReserved}',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      ' This parking space has expired or the reservation has been cancelled.\n',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
