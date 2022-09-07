import 'package:flutter/material.dart';
import 'package:greenpark/controllers/login_controller.dart';
import 'package:provider/provider.dart';
import '../pages/WelcomePage.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => LoginController(),
            child: WelcomePage(),
          )
        ],
        child: MaterialApp(
          title: 'Start application',
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          debugShowCheckedModeBanner: false,
          home: const WelcomePage(),
        ));
  }
}
