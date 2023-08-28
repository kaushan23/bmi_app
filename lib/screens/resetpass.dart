import 'package:bmiapp/app_functions/validator.dart';
import 'package:bmiapp/screens/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final validate = AppValidators();
    final resetform = GlobalKey<FormState>();

    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/login.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      top: 60.0,
                    ),
                    child: const Text(
                      'RESET NOW',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                      ),
                    ),
                  ),
                ],
              ),
              Form(
                key: resetform,
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.5,
                      left: 35,
                      right: 35,
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          // obscureText: true,
                          controller: email,
                          validator: (value) => validate.validateEmail(value!),
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: const Icon(Icons.email_outlined),
                            fillColor: const Color.fromARGB(255, 245, 242, 242),
                            filled: true,
                            // hintText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  maximumSize: const Size(250.0, 90.0),
                                  minimumSize: const Size(170.0, 60.0),
                                  backgroundColor:
                                      const Color.fromARGB(255, 53, 49, 49),
                                  shape: const StadiumBorder(),
                                ),
                                onPressed: () {
                                  if (resetform.currentState!.validate()) {
                                    resetform.currentState!.save();
                                    FirebaseAuth.instance
                                        .sendPasswordResetEmail(
                                            email: email.text);
                                  }
                                },
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  //crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.refresh,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      '   RESET NOW',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                        const SizedBox(height: 30.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Do you want to SignIn?',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            TextButton(
                              onPressed: () => Get.to(() => const SignIn()),
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
