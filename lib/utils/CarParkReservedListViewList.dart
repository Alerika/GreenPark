import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greenpark/pages/HomePage.dart';
import '../models/ParkModel.dart';
import '../models/ReservedParkModel.dart';

import '../pages/ParkSettingPage.dart';
import 'AlertDialogPopUp.dart';

class CarParkReservedViewList extends StatefulWidget {
  CarParkReservedViewList({Key? key}) : super(key: key);
  final db = FirebaseFirestore.instance;

  @override
  State<CarParkReservedViewList> createState() => _CarParkListViewListState();

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

class _CarParkListViewListState extends State<CarParkReservedViewList> {
  _CarParkListViewListState();

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<ReservedParkModel>>(
        stream: CarParkReservedViewList().readReservedParking(),
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
    if (parkModel.user == user.email &&
        (parkModel.deletedOrExpired == false && parkModel.reserved == true)) {
      return Card(
          child: ListTile(
              title: Text(parkModel.description),
              subtitle: const Text("reserved"),
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
    final DateTime today = DateTime.now();
    final DateTime reserved = parkModel.timestampReserved;
    final docParkOriginal =
        FirebaseFirestore.instance.collection('carParks').doc(parkModel.id);
    final docReservedPark = FirebaseFirestore.instance
        .collection('reservedCarPark')
        .doc(parkModel.id);
    if (user.email == parkModel.user &&
        parkModel.reserved == true &&
        parkModel.deletedOrExpired == false) {
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
                        '   Latitude: ${parkModel.latitude}\n   Longitude: ${parkModel.longitude}',
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        ' Do you want delete this booking?\n',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MaterialButton(
                        color: Colors.red,
                        onPressed: () {
                          docReservedPark.update({
                            'deletedOrExpired': true,
                          });
                          docParkOriginal.update({
                            'numberParking': FieldValue.increment(1),
                          });
                          AlertDialogPopup.showPopUp(context, "SUCCESS",
                              "The reservation has been cancelled");
                        },
                        child: const Text(
                          'CALCEL',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ));
    }
    return const SizedBox();
  }
}
