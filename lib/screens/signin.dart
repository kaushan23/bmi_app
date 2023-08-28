import 'package:bmiapp/screens/resetpass.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_functions/validator.dart';
import '../auth/auth_functions.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final signInForm = GlobalKey<FormState>();
  final auth = Authentication();
  final validate = AppValidators();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    top: 60.0,
                  ),
                  child: const Text(
                    'BMI CALCULATOR',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Sign in',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 100, 20, 40),
                  child: Column(
                    children: [
                      Form(
                          key: signInForm,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: email,
                                validator: (value) =>
                                    validate.validateEmail(value!),
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'E-mail'),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              TextFormField(
                                obscureText: true,
                                controller: password,
                                validator: (value) =>
                                    validate.validatePassword(value!),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Password',
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () =>
                                        Get.to(() => const ResetPassword()),
                                    child: const Text(
                                      'Forgot Password',
                                      style: TextStyle(
                                          decoration: TextDecoration.underline),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 25.0,
                              ),
                              Row(children: [
                                Expanded(
                                  child: ElevatedButton(
                                    child: const Text('Login'),
                                    onPressed: () {
                                      if (signInForm.currentState!.validate()) {
                                        signInForm.currentState!.save();
                                        auth.signInWithEmailAndPassword(
                                            email, password);
                                      }
                                    },
                                  ),
                                )
                              ]),
                            ],
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
