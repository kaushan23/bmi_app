import 'package:bmiapp/screens/main_page.dart';
import 'package:bmiapp/screens/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PageSwitcher extends StatelessWidget {
  const PageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("Something Went Wrong"),
          );
        } else if (snapshot.hasData) {
          return const MainPage();
        } else {
          return const SignIn();
        }
      },
    );
  }
}
