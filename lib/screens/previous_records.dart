import 'package:bmiapp/screens/main_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../auth/auth_functions.dart';
import '../models/bmi_data.dart';

class PreviousRecordsScreen extends StatefulWidget {
  final String? currentUserUid;

  const PreviousRecordsScreen({super.key, this.currentUserUid});

  @override
  State<PreviousRecordsScreen> createState() => _PreviousRecordsScreenState();
}

class _PreviousRecordsScreenState extends State<PreviousRecordsScreen> {
  final auth = Authentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () => Get.to(() => const MainPage()),
                      icon: const Icon(
                        FontAwesomeIcons.houseChimneyUser,
                      )),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      auth.signOut();
                    },
                    child: const Text("LogOut"),
                  )
                ],
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1,
                indent: 16,
                endIndent: 16,
              ),
              const Image(
                  image:
                      AssetImage("assets/images/previous_records_image.jpg")),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Your Previous BMI Records",
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF385a64),
                          ),
                        ),
                      ),
                      // Add more widgets horizontally as needed
                    ],
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('bmi_data')
                      // .where('userId', isEqualTo: widget.currentUserUid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }

                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final data = snapshot.data!.docs;

                    return Scrollbar(
                      thumbVisibility: true,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final doc = data[index];
                          final bmiData = BmiData.fromJson(
                              doc.data() as Map<String, dynamic>);

                          final formattedTimestamp = bmiData.timestamp != null
                              ? DateFormat.yMMMd()
                                  .format(bmiData.timestamp!.toDate())
                              : 'Unknown';

                          return Card(
                            color: const Color(0xFF1dd1a1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side: const BorderSide(
                                    color: Colors.transparent, width: 1)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          FontAwesomeIcons.calendarDays,
                                          color: Color(0xFFFFFFFF),
                                        ),
                                        const SizedBox(width: 50),
                                        Text(
                                          formattedTimestamp,
                                          style: const TextStyle(
                                              fontSize: 20, letterSpacing: 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          FontAwesomeIcons.coins,
                                          color: Color(0xFFFFFFFF),
                                        ),
                                        const SizedBox(width: 50),
                                        Text(
                                          bmiData.bmi.toString(),
                                          style: const TextStyle(
                                              fontSize: 20, letterSpacing: 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          FontAwesomeIcons.heartCircleCheck,
                                          color: Color(0xFFFFFFFF),
                                        ),
                                        const SizedBox(width: 50),
                                        Text(
                                          bmiData.bmiComment,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              letterSpacing: 1,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
