import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ParkingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 200,
          color: Colors.green[100],
        ),
      ),
    ]));
  }
}
