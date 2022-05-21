import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<LoginPage> createState() => _LoginPageState();
  
}

class _LoginPageState  extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Posizionamento')),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    child: const Text('LOGIN')),
                Container(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                            margin: const EdgeInsets.only(right: 8.0),
                            child: const Text('USERNAME')),
                        const Flexible(child: TextField()),
                      ],
                    )),
                Container(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                            margin: const EdgeInsets.only(right: 8.0),
                            child: const Text('PASSWORD')),
                        const Flexible(
                            child: TextField(
                              obscureText: true,
                            )),
                      ],
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    RaisedButton(
                      child: const Text('Login'),
                      onPressed: () => {},
                    )
                  ],
                )
              ]),
        ));
  }
    //throw UnimplementedError();
  }

