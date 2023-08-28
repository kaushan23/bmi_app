import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

BmiData bmiDataFromJson(String str) => BmiData.fromJson(json.decode(str));

String bmiDataToJson(BmiData data) => json.encode(data.toJson());

class BmiData {
  String name;
  String address;
  String age;
  String bmi;
  String bmiComment;
  final Timestamp? timestamp;

  BmiData({
    required this.name,
    required this.address,
    required this.age,
    required this.bmi,
    required this.bmiComment,
    required this.timestamp,
  });

  factory BmiData.fromJson(Map<String, dynamic> json) => BmiData(
        name: json["name"],
        address: json["address"],
        age: json["age"],
        bmi: json["bmi"] ?? 0.0,
        bmiComment: json["bmiComment"],
        timestamp: json["timestamp"] as Timestamp?,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "age": age,
        "bmi": bmi,
        "bmiComment": bmiComment,
        "timestamp": FieldValue.serverTimestamp(),
      };
}
