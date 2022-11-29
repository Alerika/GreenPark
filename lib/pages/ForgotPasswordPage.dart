import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:greenpark/pages/AlertDialogPopUp.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      AlertDialogPopup.showPopUp(context, "SUCCESS",
          'Password reset link sent! Check your email and then try to login. If you have not received anything, please check your spam or make sure you have entered the correct e-mail.');
    } on FirebaseAuthException catch (e) {
      print(e);
      AlertDialogPopup.showPopUp(context, "ERROR",
          'Something went wrong. Try again to reset the password!');
    }
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
              image: AssetImage('forgot_password.png')),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 130,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xB88BC34A),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                width: MediaQuery.of(context).size.width,
                height: (MediaQuery.of(context).size.height / 2) -120,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 70,
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 40),
                      child: Text(
                        'Enter your Email and we will sent you a password reset link',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    emailField(),
                    const SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                      onPressed: () {
                        passwordReset();
                      },
                      child: const Text('Reset password'),
                      color: Colors.lightGreen,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Padding emailField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        autofocus: false,
        controller: _emailController,
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
          _emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          hintText: "example@gmail.com",
          fillColor: Colors.grey[200],
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.green),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: UnderlineInputBorder(
              borderSide: const BorderSide(color: Colors.lightGreen),
              borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  BoxDecoration image() {
    return const BoxDecoration(
      image: DecorationImage(
          alignment: Alignment.topCenter,
          image: AssetImage('forgot_password.png')),
      color: Color(0xA38BC34A),
    );
  }
}
