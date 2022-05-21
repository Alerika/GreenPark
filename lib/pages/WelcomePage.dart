
import 'dart:ui';

import 'package:flutter/material.dart';


class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(title: const Text("WELCOME",textAlign: TextAlign.end),
     ),
     body: Container(
     decoration: const BoxDecoration(
       image: DecorationImage(
           image: AssetImage("background2.png"),
           fit: BoxFit.cover),
     ),
       child: Center(
     child: Column(
     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children:  <Widget>[SizedBox( height: 280, width: 700,
    child: Image.asset('logo_car_fullname.png'),
    ),

         SizedBox( height: 400, width: 800,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          RaisedButton(
            child: const Text('SIGN IN',style: TextStyle(fontStyle: FontStyle.normal)),
            color: Colors.lightGreen.shade300,
            onPressed: () => {},
          ),
          RaisedButton(
            child: const Text('LOGIN',style: TextStyle(fontStyle: FontStyle.normal)),
            color: Colors.lightGreen.shade300,
            onPressed: () => {},
          )
        ],
      ),),
    ],

    ),
     ),
     ),
   );

  }

}
