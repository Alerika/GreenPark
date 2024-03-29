import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:greenpark/utils/AlertDialogPopUp.dart';
import 'package:greenpark/pages/LoginPage.dart';
import 'package:greenpark/pages/WelcomeUserLoggedPage.dart';

class ChangeLoginStatePage extends StatelessWidget {
  const ChangeLoginStatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text("Something went wrong!"));
            } else if (snapshot.hasData) {
              return const WelcomeUserLoggedPage();
            } else {
              return const LoginPage();
            }
          }),
    );
  }
}

