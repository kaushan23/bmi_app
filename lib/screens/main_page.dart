// import 'dart:js_util';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../app_functions/app_functions.dart';
import '../app_functions/validator.dart';
import '../auth/auth_functions.dart';
import '../constants/constant.dart';
import '../models/bmi_data.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final authFunctions = Authentication();
  final appfunctions = AppFunctions();
  final validate = AppValidators();
  final formkey = GlobalKey<FormState>();
  int height = 150;
  int weight = 70;
  int age = 0;
  String name = "";
  String address = "";
  String date = "";

  List<BmiData> bmidataitem = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dateinput = TextEditingController();

  Map<String, dynamic> userInfo = {};

  void clearTextFields() {
    nameController.clear();
    addressController.clear();
    dateinput.clear();
  }

  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        age = calculateAge(selectedDate);
      });
    }
  }

  String gender = "";
  late double bmi = calculateBMI(height: height, weight: weight);
  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 25, 18, 61),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 45, 35, 95),
        elevation: 0,
        toolbarHeight: 60,
        leading: const IconButton(
          onPressed: null,
          icon: Icon(
            Icons.bar_chart_rounded,
            color: Colors.grey,
          ),
        ),
        actions: [
          FloatingActionButton(
              onPressed: () => authFunctions.signOut(),
              child: const Icon(Icons.logout)),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                    key: formkey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  gender = "Male";
                                });
                              },
                              child: Container(
                                height: 200,
                                width: 175,
                                decoration: BoxDecoration(
                                    color: gender == "Male"
                                        ? Colors.black.withAlpha(80)
                                        : Colors.grey.withAlpha(30),
                                    borderRadius: BorderRadius.circular(20)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: const Column(
                                  children: [
                                    Icon(
                                      Icons.male,
                                      size: 150.0,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "MALE",
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(206, 255, 255, 255),
                                        fontSize: 20.0,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  gender = "Female";
                                });
                              },
                              child: Container(
                                height: 200,
                                width: 175,
                                decoration: BoxDecoration(
                                    color: gender == "Female"
                                        ? Colors.black.withAlpha(80)
                                        : Colors.grey.withAlpha(30),
                                    borderRadius: BorderRadius.circular(20)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: const Column(
                                  children: [
                                    Icon(
                                      Icons.female,
                                      size: 150.0,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "FEMALE",
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(206, 255, 255, 255),
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.withAlpha(30),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [
                                      const Text(
                                        "HEIGHT\n    (cm)",
                                        style: kInputLabelColor2,
                                      ),
                                      Text(
                                        "$height",
                                        style: kInputLabelColor,
                                      ),
                                      Row(
                                        children: [
                                          FloatingActionButton(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 112, 116, 117),
                                            onPressed: () {
                                              setState(() {
                                                if (height > 50) height--;
                                                bmi = calculateBMI(
                                                    height: height,
                                                    weight: weight);
                                              });
                                            },
                                            child: const Icon(
                                              Icons.remove,
                                              size: 35.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          FloatingActionButton(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 112, 116, 117),
                                            onPressed: () {
                                              setState(() {
                                                if (height < 220) height++;
                                                bmi = calculateBMI(
                                                    height: height,
                                                    weight: weight);
                                              });
                                            },
                                            child: const Icon(
                                              Icons.add,
                                              size: 35.0,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.withAlpha(30),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [
                                      const Text(
                                        "WEIGHT\n    (kg)",
                                        style: kInputLabelColor2,
                                      ),
                                      Text(
                                        "$weight",
                                        style: kInputLabelColor,
                                      ),
                                      Row(
                                        children: [
                                          FloatingActionButton(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 112, 116, 117),
                                            onPressed: () {
                                              setState(() {
                                                if (weight > 10) weight--;
                                                bmi = calculateBMI(
                                                    height: height,
                                                    weight: weight);
                                              });
                                            },
                                            child: const Icon(
                                              Icons.remove,
                                              size: 35.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          FloatingActionButton(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 112, 116, 117),
                                            onPressed: () {
                                              setState(() {
                                                if (weight < 220) weight++;
                                                bmi = calculateBMI(
                                                    height: height,
                                                    weight: weight);
                                              });
                                            },
                                            child: const Icon(
                                              Icons.add,
                                              size: 35.0,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  bmi.toStringAsFixed(2),
                                  style: kInputLabelColor.copyWith(
                                      color: kOutputTextColor, fontSize: 60),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              result(bmi),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 72, 238, 66),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Text(
                              "${selectedDate.toLocal()}".split(' ')[0],
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 72, 238, 66)),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            ElevatedButton(
                              onPressed: () => _selectDate(context),
                              child: const Text('Select DOB'),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              "Age: $age",
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 72, 238, 66)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Column(
                          children: [
                            TextFormField(
                              controller: nameController,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintStyle: TextStyle(color: Colors.blue),
                                hintText: "Enter Your Name",
                              ),
                              validator: (value) =>
                                  validate.validateName(value!),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                              controller: addressController,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintStyle: TextStyle(color: Colors.blue),
                                hintText: "Enter Your Address",
                              ),
                              validator: (value) =>
                                  validate.validateAddress(value!),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FloatingActionButton(
                                backgroundColor:
                                    const Color.fromARGB(255, 112, 116, 117),
                                onPressed: () {
                                  if (formkey.currentState!.validate()) {
                                    formkey.currentState!.save();
                                    final bmidata = BmiData(
                                        name: name,
                                        address: addressController.text,
                                        age: age.toString(),
                                        bmi: bmi.toStringAsFixed(2),
                                        bmiComment: result(bmi),
                                        timestamp: Timestamp.now());
                                    appfunctions.addBmiData(bmidata);
                                  }
                                },
                                child: const Text(
                                  "Save",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )),
                            const SizedBox(width: 20.0),
                            FloatingActionButton(
                                backgroundColor:
                                    const Color.fromARGB(255, 112, 116, 117),
                                onPressed: () {
                                  if (formkey.currentState!.validate()) {
                                    formkey.currentState!.save();
                                    setState(() {
                                      name = nameController.text;
                                      address = addressController.text;
                                    });
                                  }
                                },
                                child: const Text(
                                  "Done",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )),
                            const SizedBox(width: 20.0),
                            FloatingActionButton(
                                backgroundColor:
                                    const Color.fromARGB(255, 112, 116, 117),
                                onPressed: () {
                                  setState(() {
                                    clearTextFields();
                                  });
                                },
                                child: const Text(
                                  "clear",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                      ],
                    )),
                Column(
                  children: [
                    Text(
                      "Your Name is:  $name",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 72, 238, 66),
                        fontSize: 25.0,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Your Address is: $address",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 72, 238, 66),
                        fontSize: 25.0,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Column(
                  children: [
                    Text(
                      "Your Age is :  $age",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 72, 238, 66),
                        fontSize: 25.0,
                      ),
                    )
                  ],
                ),
                const SizedBox(width: 20.0),
                Column(
                  children: <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: null,
                      child: const Text('Save'),
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

  double calculateBMI({required int height, required int weight}) {
    return (weight / (height * height)) * 10000;
  }

  int calculateAge(DateTime dob) {
    DateTime now = DateTime.now();
    int age = now.year - dob.year;
    if (now.month < dob.month ||
        (now.month == dob.month && now.day < dob.day)) {
      age--;
    }
    return age;
  }

  String result(bmi) {
    if (bmi! < 18.5) {
      return "You are UNDERWEIGHT";
    } else if (bmi! < 24.9) {
      return "You are NORMAL";
    } else if (bmi! < 29.9) {
      return "You are OVERWEIGHT";
    } else if (bmi! < 24.9) {
      return "You are OBESE";
    } else {
      return "You are EXTREMELY OBESE";
    }
  }
}
