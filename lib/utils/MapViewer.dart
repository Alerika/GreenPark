import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greenpark/models/ParkModel.dart';

import 'CarParkListView.dart';

class MapViewer extends StatefulWidget {
  @override
  State<MapViewer> createState() => MapViewerState();
}

class MapViewerState extends State<MapViewer> {
  final Completer<GoogleMapController> _controller = Completer();
  var locationMessage = "";
  late Position currentPosition;
  late final List<Marker> _markers = setCarList();

  List<Marker> setCarList() {
    List<Marker> list = <Marker>[];
    CarParkListViewList().readParking().listen((listOfStrings) {
      // From this point you can use listOfStrings as List<String> object
      // and do all other business logic you want
      double x = BitmapDescriptor.hueGreen;
      int cont = 0;

      for (ParkModel myString in listOfStrings) {
        String title =
            "${myString.description}: still ${myString.numberParking} free parking";
        var currMarker = Marker(
            markerId: MarkerId((cont++).toString()),
            icon: BitmapDescriptor.defaultMarkerWithHue(x),
            position: LatLng(myString.latitude, myString.longitude),
            infoWindow: InfoWindow(title: title));
        list.add(currMarker);
      }
    });
    return list;
  }

  late CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  MapViewerState() {
    getCurrentLocation();
  }

  void getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permission in are permanently denied, we cannot request permission');
    }
    try {
      Position newposition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      setState(() {
        currentPosition = newposition;
        int cont = 1;
        _markers.add(Marker(
            markerId: MarkerId((cont).toString()),
            position: LatLng(newposition.latitude, newposition.longitude),
            infoWindow: InfoWindow(title: 'me')));

        _kGooglePlex = CameraPosition(
          target: LatLng(currentPosition.latitude, currentPosition.longitude),
          zoom: 14.4746,
        );
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          initialCameraPosition: _kGooglePlex,
          markers: Set<Marker>.of(_markers),
          mapType: MapType.hybrid,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: _goToTheLake,
          child: const Icon(Icons.gps_fixed_rounded),
        ));
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
  }
}
