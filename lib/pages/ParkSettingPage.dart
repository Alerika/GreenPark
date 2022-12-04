import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:greenpark/controllers/ReservedParkingController.dart';
import 'package:greenpark/models/ParkModel.dart';
import 'package:greenpark/models/ReservedParkModel.dart';
import 'package:greenpark/pages/HomePage.dart';
import 'package:greenpark/utils/AlertDialogPopUp.dart';

import '../utils/CarParkListView.dart';

class ParkSettingPage extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;

  ParkModel parking;

  ParkSettingPage(this.parking);

  @override
  Widget build(BuildContext context) {
    bool isFull = (parking.numberParking != 0);
    return Scaffold(
        appBar: AppBar(
          title: Text(parking.description),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                CircleAvatar(
                  radius: 150,
                  child: CircleAvatar(
                    radius: 150,
                    backgroundImage: AssetImage('logo_circular.png'),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  parking.description,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'There are ${parking.numberParking} free parking yet \n',
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    upDate(context, isFull, parking),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  Widget upDate(BuildContext context, bool isFull, ParkModel parking) {
    bool deleted = false;
    bool expired = false;
    bool reserved = false;
    ParkModel? parkModel;
    CarParkListViewList().readParking().listen((listOfStrings) {
      for (ParkModel myString in listOfStrings) {
        if (parking == myString) {
          parkModel = myString;
        }
      }
    });
    ReservedParkModel? reservedPark;
    CarParkListViewList().readReservedParking().listen((listOfStrings) {
      for (ReservedParkModel myString in listOfStrings) {
        reserved = false;
        if (user.email == myString.user &&
            parking.latitude == myString.latitude &&
            parking.longitude == myString.longitude) {
          reservedPark = myString;
        }
      }
    });
    if (reservedPark != null) {
      final docPark = FirebaseFirestore.instance
          .collection('reservedCarPark')
          .doc(reservedPark!.id);
      final docParkOriginal =
          FirebaseFirestore.instance.collection('carParks').doc();
      final DateTime end = DateTime.now();
      final Duration duration = end.difference(reservedPark!.timestampReserved);
      if (duration.inMinutes > 30 && reservedPark!.deletedOrExpired == false) {
        docPark.update({
          'deletedOrExpired': true,
        });
        AlertDialogPopup.showPopUp(
            context, "TIME EXPIRED", "This car park is no longer reserved");
        return const Text('This booking is not enabled\n',
            style: TextStyle(
              fontSize: 27,
              color: Colors.green,
            ));
      } else if (duration.inMinutes < 30 &&
          reservedPark!.deletedOrExpired == false) {
        return Column(children: [
          Text('Do you want delete this booking?\n',
              style: TextStyle(
                fontSize: 27,
                color: Colors.red[800],
              )),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2.5,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: Colors.red[800],
            ),
            child: MaterialButton(
              onPressed: () {
                docPark.update({
                  'deletedOrExpired': true,
                });
                AlertDialogPopup.showPopUp(context, "CANCEL SUCCESS",
                    "This booking was canceled with success");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
              child: const Text(
                'CANCEL',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          )
        ]);
      }
      if (isFull == true) {
        return const Text('Impossible to booking this park.\n Parking Full!',
            style: TextStyle(
              fontSize: 27,
              color: Colors.green,
            ));
      }
    }
    return Column(children: [
      const Text('Do you want reserve this car park?\n',
          style: TextStyle(
            fontSize: 22,
            color: Colors.green,
          )),
      const SizedBox(
        height: 10,
      ),
      MaterialButton(
        color: Colors.green,
        onPressed: () {
          ReservedPark().createReservedParking(
              parkModel: ReservedParkModel(
                  deletedOrExpired: false,
                  description: parking.description,
                  latitude: parking.latitude,
                  longitude: parking.longitude,
                  reserved: true,
                  timestampReserved: DateTime.now(),
                  user: user.email.toString()));

          AlertDialogPopup.showPopUp(context, "SUCCESS", "successful booking");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        },
        child: const Text(
          'RESERVE',
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ),
    ]);
  }
}
