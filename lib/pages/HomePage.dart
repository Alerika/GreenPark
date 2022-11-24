import 'package:flutter/material.dart';
import 'package:greenpark/pages/MapViewer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  final String title = 'Personal Budget';

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int _selectedIndex = 0;

  setTabs(BuildContext context) {
    var tabs = [
     // MapViewer.map(context),
      MyApp(),
      Center(
        child: Text('Elenco'),
      ),
      Center(
        child: Text('Search'),
      ),
      Center(
        child: Text('Oggi'),
      ),
      Center(
        child: Text('Altro'),
      ),
    ];
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), actions: <Widget>[
        IconButton(icon: const Icon(Icons.settings), onPressed: () => {}),
        IconButton(icon: const Icon(Icons.refresh), onPressed: () => {}),
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
              icon: Icon(Icons.home),
              backgroundColor: Colors.green,
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              backgroundColor: Colors.green,
              label: 'Elenco',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              backgroundColor: Colors.green,
              label: 'Dettaglio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              backgroundColor: Colors.green,
              label: 'Oggi',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.apps),
              backgroundColor: Colors.green,
              label: 'Altro',
            ),
          ]),
    );
  }
}
