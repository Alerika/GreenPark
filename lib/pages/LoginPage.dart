import 'package:flutter/material.dart';
import 'package:greenpark/pages/register.dart';

import 'customWidget.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<LoginPage> createState() => _LoginPageState();
  
}

class _LoginPageState  extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,


        decoration: const BoxDecoration(

          image: DecorationImage(
              alignment: Alignment. topCenter,
              image: AssetImage('logo_circular.png')),

          color: Color(0xA38BC34A),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: const  Color(0xB88BC34A),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.8,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 35,
                    ),
                    const Text(
                      "Sign In",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                    Container(

                      width: MediaQuery.of(context).size.width / 1.4,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 5.0,
                          right: 5.0,
                        ),
                        child: TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: "something@gmail.com",
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                          cursorColor: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.4,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 5.0,
                          right: 5.0,
                        ),
                        child: TextFormField(
                          obscureText: true,
                          controller: passwordController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            hintText: "Password",
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                          cursorColor: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MaterialButton(
                            onPressed: () {},
                            child: const Text("Forgot Password"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 40,
                    ),
                    const CustomButton(
                      height: 44,
                      inputText: 'Sign In',
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("I'm a new user."),
                        MaterialButton(
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
                              color: Color(0xff0d7703),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
