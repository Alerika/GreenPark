import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:greenpark/controllers/login_controller.dart';
import 'package:greenpark/pages/AlertDialogPopUp.dart';
import 'package:greenpark/controllers/ChangeLoginStatePageController.dart';
import 'package:greenpark/pages/ForgotPasswordPage.dart';
import 'package:greenpark/pages/RegistrationPage.dart';
import 'package:greenpark/pages/WelcomeUserLoggedPage.dart';
import 'package:provider/provider.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // form key
  final _formKey = GlobalKey<FormState>();
  bool validEmail = true;
  bool validPassword = true;

  // editing controller
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // firebase
  final _auth = FirebaseAuth.instance;

// string for displaying the error Message
  String? errorMessage;

  Future signIn() async {
    bool registeredEmail = false;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      registeredEmail = true;
      print("opsssssssssssssssssssssssssssssssss");
    } on FirebaseAuthException catch (e) {
      print(e);
      String errorCauseMessage = "";
      String errorMessage = "";
      if (validEmail && !registeredEmail) {
        print("aaaaaaaaaaaaaaaaaaaaaaaaaaassssssss");
        errorCauseMessage = "ERROR EMAIL";
        errorMessage = "This  account don't exist create a new one";
      } else {
        print("bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb");
        errorCauseMessage = "ERROR";
        errorMessage = "Wrong email or password. Please try again ";
      }
      AlertDialogPopup.showPopUp(context, errorCauseMessage, errorMessage);
    }

    //navigator.of(context) not working!
    navigatorKey.currentState?.popUntil((route) => route.isFirst);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPasswordPage(),
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
                    GestureDetector(
                      onTap: signIn,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.4,
                        height: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: const Color(0xff0d7703),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            signIn();
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white,
                            ),
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
                                builder: (context) => const RegistrationPage(),
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
                    SizedBox(
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
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const Center(child: CircularProgressIndicator());
                                      },
                                    );
                                    LoginController().googleLogin();
                                    Navigator.of(context).pop();
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
    ));
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
            // reg expression for email validation
            if (value!.isEmpty ||
                (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                    .hasMatch(value))) {
              validEmail = false;
            }
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
            if (value!.isEmpty || (!RegExp(r'^.{6,}$').hasMatch(value))) {
              validPassword = false;
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
