
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:greenpark/pages/LoginPage.dart';
import 'package:greenpark/pages/register.dart';


class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);
    @override
    _WelcomePageState createState() => _WelcomePageState();
  }


class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
  body: Container(
  width: MediaQuery.of(context).size.width,
  height: MediaQuery.of(context).size.height,
  decoration: const BoxDecoration(
      color: Color(0x9192C74E),
  ),
  child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
  SizedBox(height: MediaQuery.of(context).size.height / 40),
  Image.asset('logo_car_fullname.png'),
  SizedBox(height: MediaQuery.of(context).size.height / 40),
  Container(
  width: MediaQuery.of(context).size.width / 1.4,
  height: 44,
  decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(10.0),
  color: const Color(0xff0d7703),
  ),
  child: MaterialButton(
  onPressed: () {
  Navigator.push(
  context,
  MaterialPageRoute(
  builder: (context) => RegisterView(),
  ),
  );
  },
  child: const Text(
  "Sign Up",
  style: TextStyle(
  color: Colors.white,
  ),
  ),
  ),
  ),
  SizedBox(height: MediaQuery.of(context).size.height / 50),
  Container(
  width: MediaQuery.of(context).size.width / 1.4,
  height: 44,
  decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(10.0),
  border: Border.all(
  color: Colors.black,
  ),
  ),
  child: MaterialButton(
  onPressed: () {
  Navigator.push(
  context,
  MaterialPageRoute(
  builder: (context) => const LoginPage(title: '',),
  ),
  );
  },
  child: const Text(
  "Sign In",
  style: TextStyle(
  color: Colors.black,
  ),
  ),
  ),
  ),
  ],
  ),
  ),
  );
  }
}
