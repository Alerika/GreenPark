import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:greenpark/controllers/login_controller.dart';
import 'package:greenpark/pages/ForgotPasswordPage.dart';
import 'package:greenpark/pages/RegistrationPage.dart';
import 'package:greenpark/pages/WelcomeUserPage.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // form key
  final _formKey = GlobalKey<FormState>();

  // editing controller
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // firebase
  final _auth = FirebaseAuth.instance;

// string for displaying the error Message
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.topCenter,
              image: AssetImage('logo_circular.png')),
          color: Color(0xA38BC34A),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xB88BC34A),
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
                      height: MediaQuery.of(context).size.height / 80,
                    ),
                    emailField(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 80,
                    ),
                    passwordField(),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgotPasswordPage(),
                                ),
                              );
                            },
                            child: const Text(
                              "Forgot Password",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                              builder: (context) => WelcomeUserPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegistrationPage(),
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
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width / 1.3,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("or"),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 80,
                              ),
                              GestureDetector(
                                  child: Image.asset(
                                    "google.png",
                                    width: 240,
                                  ),
                                  onTap: () {
                                    Provider.of<LoginController>(context,
                                            listen: false)
                                        .googleLogin();
                                    print(
                                        "gneeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee\n\n\n");
                                  }),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                  child: Image.asset(
                                    "fb.png",
                                    width: 240,
                                  ),
                                  onTap: () {
                                    Provider.of<LoginController>(context,
                                            listen: false)
                                        .facebooklogin();
                                  }),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container emailField() {
    return Container(
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
          autofocus: false,
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value!.isEmpty) {
              return ("Please Enter Your Email");
            }
            // reg expression for email validation
            if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                .hasMatch(value)) {
              return ("Please Enter a valid email");
            }
            return null;
          },
          onSaved: (value) {
            emailController.text = value!;
          },
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            hintText: "example@gmail.com",
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
    );
  }

  Container passwordField() {
    return Container(
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
          autofocus: false,
          controller: passwordController,
          validator: (value) {
            RegExp regex = new RegExp(r'^.{6,}$');
            if (value!.isEmpty) {
              return ("Password is required for login");
            }
            if (!regex.hasMatch(value)) {
              return ("Enter Valid Password(Min. 6 Character)");
            }
          },
          onSaved: (value) {
            passwordController.text = value!;
          },
          textInputAction: TextInputAction.done,
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
    );
  }
}
