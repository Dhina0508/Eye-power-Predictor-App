// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:eye_power_prediction/model/prediction_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future getPrediction(
      {required String leftImage,
      required String rightImage,
      required String bothImage,
      required double leftFontSize,
      required double rightFontSize,
      required double bothFontSize}) async {
    var encoded = jsonEncode({
      "left_image": leftImage,
      "right_image": rightImage,
      "both_image": bothImage,
      "left_fontsize": rightFontSize,
      "right_fontsize": leftFontSize,
      "both_eye_fontsize": bothFontSize
    });
    print(encoded);
    log(encoded);
    var res = await http.post(
        Uri.parse("https://main-project-yto0.onrender.com/api/power/"),
        headers: {"Content-Type": "application/json"},
        body: encoded);
    log(res.body);
    print(res.body);
    if (res.statusCode >= 200 && res.statusCode <= 300) {
      return PredictionModel.fromJson(jsonDecode(res.body));
    } else {
      Fluttertoast.showToast(msg: res.body);
      throw Exception("$encoded===>${res.body}");
    }
  }
}
