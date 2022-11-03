import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:greenpark/pages/LoginPage.dart';
import 'package:greenpark/pages/ChangeLoginStatePage.dart';
import 'package:greenpark/pages/WelcomeUserLoggedPage.dart';

class FbLoginManagementPage extends StatelessWidget {
  const FbLoginManagementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const WelcomeUserLoggedPage();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
