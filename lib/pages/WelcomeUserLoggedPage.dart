import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WelcomeUserLoggedPage extends StatefulWidget {
  const WelcomeUserLoggedPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WelcomeUserLoggedPageState();
}

class _WelcomeUserLoggedPageState extends State<WelcomeUserLoggedPage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('signed in as: ' + user.email!),
            MaterialButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              color: Colors.green,
              child: const Text('sign out'),
            )
          ],
        ),
      ),
    );
  }
}
