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
  late final List<Marker> _markers = <Marker>[];

  @override
  void initState() {
    super.initState();
    _markers.addAll(setCarList());
  }

  List<Marker> setCarList() {
    List<Marker> list = <Marker>[];
    CarParkListViewList().readParking().listen((listOfStrings) {
      // From this point you can use listOfStrings as List<String> object
      // and do all other business logic you want
      double x = BitmapDescriptor.hueGreen;
      int cont = 1;

      for (ParkModel myString in listOfStrings) {
        cont = cont + 1;
        String title =
            "${myString.description}: still ${myString.numberParking} free parking";
        var currMarker = Marker(
            markerId: MarkerId((cont).toString()),
            icon: BitmapDescriptor.defaultMarkerWithHue(x),
            position: LatLng(myString.longitude, myString.latitude),
            infoWindow: InfoWindow(title: title));
        print(currMarker);
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
        double x = BitmapDescriptor.hueGreen;
        _markers.add(Marker(
            markerId: MarkerId((18).toString()),
            icon: BitmapDescriptor.defaultMarkerWithHue(x),
            position: LatLng(39.365442,16.227153),
            infoWindow: InfoWindow(title: 'UNICAL - Tatro Ingegneria: still 23 free parking')));
        _markers.add(Marker(
            markerId: MarkerId((19).toString()),
            icon: BitmapDescriptor.defaultMarkerWithHue(x),
            position: LatLng(39.364131,16.227164),
            infoWindow: InfoWindow(title: 'UNICAL - Zona Star: still 36 free parking')));
        _markers.add(Marker(
            markerId: MarkerId((40).toString()),
            icon: BitmapDescriptor.defaultMarkerWithHue(x),
            position: LatLng(39.363326, 16.226808),
            infoWindow: InfoWindow(title: 'UNICAL - DEMACS: still 36 free parking')));
        _markers.add(Marker(
            markerId: MarkerId((20).toString()),
            icon: BitmapDescriptor.defaultMarkerWithHue(x),
            position: LatLng(39.364464, 16.225196),
            infoWindow: InfoWindow(title: 'UNICAL - Bar Valentine: still 50 free parking')));
        _markers.add(Marker(
            markerId: MarkerId((21).toString()),
            icon: BitmapDescriptor.defaultMarkerWithHue(x),
            position: LatLng(39.362978, 16.224578),
            infoWindow: InfoWindow(title: 'UNICAL - Quartiere Martensson: still 37 free parking')));
        _markers.add(Marker(
            markerId: MarkerId((22).toString()),
            icon: BitmapDescriptor.defaultMarkerWithHue(x),
            position: LatLng(39.362254, 16.225761),
            infoWindow: InfoWindow(title: 'UNICAL - Tatro Ingegneria: still 23 free parking')));
        _markers.add(Marker(
            markerId: MarkerId((23).toString()),
            icon: BitmapDescriptor.defaultMarkerWithHue(x),
            position: LatLng(39.362152, 16.227758),
            infoWindow: InfoWindow(title: 'UNICAL - Biblioteca: still 56 free parking')));
        _markers.add(Marker(
            markerId: MarkerId((24).toString()),
            icon: BitmapDescriptor.defaultMarkerWithHue(x),
            position: LatLng(39.360045, 16.227468),
            infoWindow: InfoWindow(title: 'UNICAL - Museo Musnob: still 33 free parking')));
        _markers.add(Marker(
            markerId: MarkerId((25).toString()),
            icon: BitmapDescriptor.defaultMarkerWithHue(x),
            position: LatLng(39.358272, 16.226062),
            infoWindow: InfoWindow(title: 'UNICAL - Cubo Restaurant: still 60 free parking')));
        _markers.add(Marker(
            markerId: MarkerId((26).toString()),
            icon: BitmapDescriptor.defaultMarkerWithHue(x),
            position: LatLng(39.356651, 16.228423),
            infoWindow: InfoWindow(title: 'UNICAL - Polifunzionale: still 44 free parking')));
        _markers.add(Marker(
            markerId: MarkerId((27).toString()),
            icon: BitmapDescriptor.defaultMarkerWithHue(x),
            position: LatLng(39.355902, 16.229759),
            infoWindow: InfoWindow(title: 'UNICAL - Polifunzionale: still 39 free parking')));
        _markers.add(Marker(
            markerId: MarkerId((28).toString()),
            icon: BitmapDescriptor.defaultMarkerWithHue(x),
            position: LatLng(39.356621, 16.225461),
            infoWindow: InfoWindow(title: 'UNICAL - Maisonnettes: still 29 free parking')));
        _markers.add(Marker(
            markerId: MarkerId((29).toString()),
            icon: BitmapDescriptor.defaultMarkerWithHue(x),
            position: LatLng(39.355219, 16.224139),
            infoWindow: InfoWindow(title: 'UNICAL - Insieme: still 12 free parking')));
        _markers.add(Marker(
            markerId: MarkerId((30).toString()),
            icon: BitmapDescriptor.defaultMarkerWithHue(x),
            position: LatLng(39.365047, 16.226176),
            infoWindow: InfoWindow(title: 'UNICAL - Laboratorio Prove Materiali e strutture: still 10 free parking')));
        _markers.add(Marker(
            markerId: MarkerId((31).toString()),
            icon: BitmapDescriptor.defaultMarkerWithHue(x),
            position: LatLng(39.365425, 16.224080),
            infoWindow: InfoWindow(title: 'UNICAL - Chiodo2: still 40 free parking')));
        _markers.add(Marker(
            markerId: MarkerId((32).toString()),
            icon: BitmapDescriptor.defaultMarkerWithHue(x),
            position: LatLng(39.362565, 16.222289),
            infoWindow: InfoWindow(title: 'UNICAL - Martensson/Chiodo1: still 39 free parking')));
        _markers.add(Marker(
            markerId: MarkerId((33).toString()),
            icon: BitmapDescriptor.defaultMarkerWithHue(x),
            position: LatLng(39.362219, 16.225766),
            infoWindow: InfoWindow(title: 'UNICAL - Piazza Rettorato: still 30 free parking')));
        _markers.add(Marker(
            markerId: MarkerId((34).toString()),
            icon: BitmapDescriptor.defaultMarkerWithHue(x),
            position: LatLng(39.361402, 16.226718),
            infoWindow: InfoWindow(title: 'UNICAL - HackLab: still 23 free parking')));

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
          markers: Set<Marker>.of(_markers),onTap: (position){
        },
          mapType: MapType.hybrid,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: _goToTheCurrentPosition,
          child: const Icon(Icons.gps_fixed_rounded),
        ));
  }

  Future<void> _goToTheCurrentPosition() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
  }
}
