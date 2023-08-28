import 'package:bmiapp/screens/signin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 231, 240, 248),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Image(
                  fit: BoxFit.contain,
                  image: AssetImage("assets/images/background.png"),
                  width: 450.0,
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(140, 30, 0, 50),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Welcome!",
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF385a64),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Get.to(() => const SignIn()),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(20),
                          backgroundColor: const Color(0xFF385a64),
                          foregroundColor: Colors.white70,
                        ),
                        child: const Text(
                          "Lets Go",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 3,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
