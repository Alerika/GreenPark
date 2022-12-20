import 'package:flutter/material.dart';
import 'package:greenpark/utils/CarParkTodayListViewList.dart';
import 'package:greenpark/utils/MapViewer.dart';
import 'package:greenpark/pages/SettingsPage.dart';

import '../utils/CarParkDeletedExpiredListViewList.dart';
import '../utils/CarParkListView.dart';
import '../utils/CarParkReservedListViewList.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  final String title = 'GreenPark';

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int _selectedIndex = 0;

  setTabs(BuildContext context) {
    var tabs = [
      // MapViewer.map(context),
      MapViewer(),
      Center(
        child: CarParkListViewList(),
      ),
       Center(
        child: CarParkReservedViewList(),
      ),
       Center(
        child: CarParkTodayListViewList(),
      ),
       Center(
        child: CarParkDeletedExpiredListViewList(),
      ),
    ];
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: GestureDetector(
            child: Image.asset(
              "logo_car_fullname.png",
              width: 240,
            ),
          ),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.settings),
                onPressed: ()  => {
                       Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const SettingsUI()))
                    }),
            IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () async => {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()))
                    }),
          ]),
      body: setTabs(context)[_selectedIndex], //Container(),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Colors.lightGreen[900],
          unselectedItemColor: Colors.white,
          currentIndex: _selectedIndex,
          onTap: (_index) {
            setState(() {
              _selectedIndex = _index;
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              backgroundColor: Colors.green,
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_parking),
              backgroundColor: Colors.green,
              label: 'Parking',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_parking),
              backgroundColor: Colors.green,
              label: 'Reserved',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              backgroundColor: Colors.green,
              label: 'today',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.access_alarm_outlined),
              backgroundColor: Colors.green,
              label: 'deleted/expired',
            ),
          ]),
    );
  }
}
