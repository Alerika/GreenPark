import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:greenpark/utils/AlertDialogPopUp.dart';
import 'LoginPage.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final formKey = GlobalKey<FormState>();

  // editing controller
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future signUp() async {
    final isValid = formKey.currentState!.validate();

    if (!isValid) {
      String errorCauseMessage = "";
      String errorMessage = "";

      errorCauseMessage = "ERROR";
      errorMessage =
          "OH, SOMETHING WENT WRONG! TRY AGAIN. INSERT CORRECT MACH MAIL AND VALID PASSWORD";
      AlertDialogPopup.showPopUp(context, errorCauseMessage, errorMessage);
      return;
    }
    bool registeredEmail = false;
    if (passwordConfirmed()) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
                child: CircularProgressIndicator(),
              ));
      //create user
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailController.text.trim(),
                password: _passwordController.text.trim())
            .then((value) => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            )));
        registeredEmail = true;
      } on FirebaseAuthException catch (e) {
        print(e);
        String errorCauseMessage = "";
        String errorMessage = "";
        if (!registeredEmail) {
          errorCauseMessage = "ERROR EMAIL";
          errorMessage = "This account already exist. Sing in now!";
        } else {
          errorCauseMessage = "ERROR";
          errorMessage = "Wrong email or password. Please try again ";
        }
        AlertDialogPopup.showPopUp(context, errorCauseMessage, errorMessage);
      }
      //add user details
      addUserDetails(_nameController.text.trim(), _phoneController.text.trim(),
          _emailController.text.trim(), _passwordController.text.trim());
      //navigator.of(context) not working!
      navigatorKey.currentState?.popUntil((route) => route.isFirst);
      Navigator.of(context).pop();
    }
  }

  bool passwordConfirmed() {
    if (_confirmPasswordController.text.trim() ==
        _passwordController.text.trim()) {
      return true;
    }
    return false;
  }

  Future addUserDetails(String fullName, String phoneNumber, String email,
      String password) async {
    await FirebaseFirestore.instance.collection('users').add({
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'password': password,
    });
  }

// firebase
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Form(
            key: formKey,
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
                        height: MediaQuery.of(context).size.height / 1.75,
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 35,
                            ),
                            const Text(
                              "Create Account",
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
                                  controller: _nameController,
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    hintText: "Full Name",
                                    border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                  ),
                                  cursorColor: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 100,
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
                                  controller: _phoneController,
                                  keyboardType: TextInputType.phone,
                                  decoration: const InputDecoration(
                                    hintText: "Phone Number",
                                    border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                  ),
                                  cursorColor: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 100,
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
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                    hintText: "something@gmail.com",
                                    border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (email) => email != null &&
                                          !EmailValidator.validate(email)
                                      ? 'Enter a valid mail'
                                      : null,
                                  cursorColor: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 100,
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
                                  controller: _passwordController,
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    hintText: "Password",
                                    border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                  ),
                                  validator: (value) =>
                                      value != null && value.length < 8
                                          ? 'Enter min 8 characters'
                                          : null,
                                  cursorColor: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 100,
                            ),
                            confirmPasswordField(),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 30,
                            ),
                            singUpButton(),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 100,
                            ),
                            singInField(),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )));
  }

  Container confirmPasswordField() {
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
          controller: _confirmPasswordController,
          obscureText: true,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            hintText: "Confirm Password",
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

  Container singUpButton() {
    return Container(
      width: MediaQuery.of(context).size.width / 1.4,
      height: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color(0xff0d7703),
      ),
      child: MaterialButton(
        onPressed: () {
          signUp();
        },
        child: const Text(
          'Sign Up',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Row singInField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("I'm already a member."),
        MaterialButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            );
          },
          child: const Text(
            "Sign In",
            style: TextStyle(
              color: Color(0xff0d7703),
            ),
          ),
        ),
      ],
    );
  }
}
