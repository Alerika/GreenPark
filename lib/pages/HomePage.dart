
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({required Key key}) : super(key: key);

  final String title = 'Personal Budget';

  @override
  _HomePage createState() => _HomePage();
}


class _HomePage extends State<HomePage> {
  int _selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () => {}),
            IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () => {}),
          ]
      ),

      body: Container(),

      //  bottomNavigationBar: BottomAppBar(
      //    child: Container(
      //      color: Colors.grey,
      //      height: 50,
      //      child: Row(
      //        mainAxisAlignment: MainAxisAlignment.spaceAround,
      //        children: <Widget>[
      //          FlatButton(
      //            child: Text("Elenco"),
      //            onPressed: () {},
      //          ),
      //          FlatButton(
      //            child: Text("Dettaglio"),
      //            onPressed: () {},
      //          ),
      //          FlatButton(
      //            child: Text("Totali"),
      //            onPressed: () {},
      //          )
      //        ],
      //      ),
      //    ),
      //  ),

      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Colors.amber[800],
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          onTap: (_index) {
            setState(() {
              _selectedIndex = _index;
            });
          },
          items:  const <BottomNavigationBarItem> [
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
          ]
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        tooltip: 'Aggiungi spesa',
        onPressed: () {},
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      drawer: Drawer(
          child: Container(
              color: Colors.yellow,
              padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
              child: const Text("Demo Menu"))
      ),


    );
  }
}
