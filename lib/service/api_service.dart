import 'dart:convert';
import 'dart:developer';

import 'package:eye_power_prediction/model/prediction_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future getPrediction(
      {required String leftImage,
      required String rightImage,
      required String bothImage,
      required double leftFontSize,
      required double rightFontSize,
      required double bothFontSize}) async {
    var res = await http.post(
        Uri.parse("https://main-project-yto0.onrender.com/api/power/"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "left_image": leftImage,
          "right_image": rightImage,
          "both_image": bothImage,
          "left_fontsize": rightFontSize,
          "right_fontsize": leftFontSize,
          "both_eye_fontsize": bothFontSize
        }));
    log(res.body);
    if (res.statusCode >= 200 && res.statusCode <= 300) {
      return PredictionModel.fromJson(jsonDecode(res.body));
    } else {
      // ignore: avoid_print
      print("error");
    }
  }
}
