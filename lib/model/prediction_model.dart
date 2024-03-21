import 'dart:convert';

class PredictionModel {
  List<String>? diagnosis;
  List<double>? leftPower;
  List<double>? rightPower;

  PredictionModel({
    this.diagnosis,
    this.leftPower,
    this.rightPower,
  });

  factory PredictionModel.fromRawJson(String str) =>
      PredictionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PredictionModel.fromJson(Map<String, dynamic> json) =>
      PredictionModel(
        diagnosis: json["diagnosis"] == null
            ? []
            : List<String>.from(json["diagnosis"]!.map((x) => x)),
        leftPower: json["left_power"] == null
            ? []
            : List<double>.from(json["left_power"]!.map((x) => x?.toDouble())),
        rightPower: json["right_power"] == null
            ? []
            : List<double>.from(json["right_power"]!.map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "diagnosis": diagnosis == null
            ? []
            : List<dynamic>.from(diagnosis!.map((x) => x)),
        "left_power": leftPower == null
            ? []
            : List<dynamic>.from(leftPower!.map((x) => x)),
        "right_power": rightPower == null
            ? []
            : List<dynamic>.from(rightPower!.map((x) => x)),
      };
}
