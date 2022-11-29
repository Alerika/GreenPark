import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:greenpark/models/user_datails.dart';

class LoginController with ChangeNotifier {
  // object
  final _googleSignIn =  GoogleSignIn(
      scopes: <String>["email"]);
  GoogleSignInAccount? googleSignInAccount;
  UserDetails? userDetails;


  // fucntion for google login
  googleLogin() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
        scopes: <String>["email"]).signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);

  }

  // logout
  logout() async {
    FirebaseAuth.instance.signOut();
  }
}