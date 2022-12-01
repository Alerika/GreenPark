import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  late Position _currentPosition;

  late Position _previousPosition;
  late StreamSubscription<Position> _positionStream;
  double _totalDistance = 0;

  List<Position> locations = <Position>[];

  @override
  void initState() {
    super.initState();
    _calculateDistance();
  }

  Future _calculateDistance() async {
    _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
          distanceFilter: 10, accuracy: LocationAccuracy.high),
    ).listen((Position position) async {
      if ((await Geolocator.isLocationServiceEnabled())) {
        Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
            .then((Position position) {
          setState(() {
            _currentPosition = position;
            locations.add(_currentPosition);

            if (locations.length > 1) {
              _previousPosition = locations.elementAt(locations.length - 2);

              var _distanceBetweenLastTwoLocations = Geolocator.distanceBetween(
                _previousPosition.latitude,
                _previousPosition.longitude,
                _currentPosition.latitude,
                _currentPosition.longitude,
              );
              _totalDistance += _distanceBetweenLastTwoLocations;
              print('Total Distance: $_totalDistance');
            }
          });
        }).catchError((err) {
          print(err);
        });
      } else {
        print("GPS is off.");
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: const Text('Make sure your GPS is on in Settings !'),
                actions: <Widget>[
                  TextButton(
                      child: Text('OK'),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      })
                ],
              );
            });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _positionStream.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Manager'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Previous Latitude: ${_previousPosition?.latitude ?? '-'} \nPrevious Longitude: ${_previousPosition?.longitude ?? '-'}',
            ),
            SizedBox(height: 50),
            Text(
              'Current Latitude: ${_currentPosition?.latitude ?? '-'} \nCurrent Longitude: ${_currentPosition?.longitude ?? '-'}',
            ),
            SizedBox(height: 50),
            Text(
                'Distance: ${_totalDistance != null ? _totalDistance > 1000 ? (_totalDistance / 1000).toStringAsFixed(2) : _totalDistance.toStringAsFixed(2) : 0} ${_totalDistance != null ? _totalDistance > 1000 ? 'KM' : 'meters' : 0}')
          ],
        ),
      ),
    );
  }
}
