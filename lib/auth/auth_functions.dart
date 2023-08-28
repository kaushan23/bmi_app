import 'package:bmiapp/screens/main_page.dart';
import 'package:bmiapp/screens/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  signInWithEmailAndPassword(
      TextEditingController email, TextEditingController password) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email.text, password: password.text)
        .then((value) => Get.to(() => const MainPage()));
  }

  signOut() {
    FirebaseAuth.instance.signOut();
    Get.to(() => const SignIn());
  }

  signInWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleSignInAuth =
        await googleSignInAccount?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuth?.accessToken,
        idToken: googleSignInAuth?.idToken);
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    if (userCredential.user != null) {
      Get.to(() => const MainPage());
    }
  }

// signUpWithEmailAndPassword(
//       TextEditingController email, TextEditingController password) {
//     FirebaseAuth.instance
//         .createUserWithEmailAndPassword(email: email.text, password: password.text)
//         .then((value) => Get.to(() => const MainPage()));
//   }
}
