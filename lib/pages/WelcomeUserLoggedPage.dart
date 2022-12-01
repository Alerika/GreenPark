import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:greenpark/pages/HomePage.dart';

class WelcomeUserLoggedPage extends StatefulWidget {
  const WelcomeUserLoggedPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WelcomeUserLoggedPageState();
}

class _WelcomeUserLoggedPageState extends State<WelcomeUserLoggedPage> {

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 40),
            Image.asset('logo_car_fullname.png'),
            SizedBox(height: MediaQuery.of(context).size.height / 40),
            const Text(
              'Signed in as: ',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              user.displayName!,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50)),
              icon: const Icon(Icons.arrow_back, size: 32),
              label: const Text(
                'Sign Out',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () => FirebaseAuth.instance.signOut(),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50)),
                icon: const Icon(Icons.home_outlined, size: 32),
                label: const Text(
                  'HomePage',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
