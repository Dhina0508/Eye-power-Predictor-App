import 'dart:developer';
import 'dart:io';

import 'package:eye_power_prediction/model/prediction_model.dart';
import 'package:eye_power_prediction/service/api_service.dart';
import 'package:eye_power_prediction/service/firebase_service.dart';
import 'package:flutter/material.dart';

class OutputScreen extends StatefulWidget {
  const OutputScreen({
    super.key,
    required this.data,
  });
  final List data;

  @override
  State<OutputScreen> createState() => _OutputScreenState();
}

class _OutputScreenState extends State<OutputScreen> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  String left = "";
  String right = "";
  String diagonis = "";
  List imgUrl = [];
  bool isLoading = true;
  PredictionModel? pm;
  bool isError = false;
  String error = "";

  loadData() async {
    try {
      for (var i in widget.data) {
        imgUrl
            .add(await FirebaseService.uploadImageToFirebase(File(i["path"])));
      }
      log(imgUrl.toString());
      pm = await ApiService.getPrediction(
          leftImage: imgUrl[0],
          rightImage: imgUrl[1],
          bothImage: imgUrl[2],
          leftFontSize: widget.data[0]["fontsize"],
          rightFontSize: widget.data[1]["fontsize"],
          bothFontSize: widget.data[2]["fontsize"]);
      isLoading = false;
      setState(() {});
    } catch (e) {
      isError = true;
      error = e.toString();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isError
          ? Center(
              child: Text(error),
            )
          : isLoading
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: CircularProgressIndicator(
                          strokeWidth: 20,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Please wait while we analyse your data",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      )
                    ],
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.remove_red_eye_outlined,
                        size: 100,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Here is your report.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                              "Left eye: ${pm!.leftPower![0].toStringAsFixed(3)}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                          Text(
                              "right eye: ${pm!.rightPower![0].toStringAsFixed(3)}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                          Text("you might have: ${pm!.diagnosis![0]}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                        ],
                      )
                    ],
                  ),
                ),
    );
  }

  // Future getleftEyePower() async {
  //   var json = await DefaultAssetBundle.of(context)
  //       .loadString("assets/left_eye_model.json");
  //   final model = LinearRegressor.fromJson(json);
  //   final tester = DataFrame([
  //     [
  //       "left_eye_distance",
  //       'right_eye_distance',
  //       "both_eye_distance",
  //       "left_fontsize",
  //       "right_fontsize",
  //       "both_eye_fontsize"
  //     ],
  //     [
  //       widget.data[0]["distance"],
  //       widget.data[1]["distance"],
  //       widget.data[2]["distance"],
  //       widget.data[0]["fontsize"],
  //       widget.data[1]["fontsize"],
  //       widget.data[2]["fontsize"],
  //     ]
  //   ]);
  //   final prediction = model.predict(tester);
  //   return (prediction.rows.first.first).toStringAsFixed(3);
  // }

  // Future getrightEyePower() async {
  //   var json = await DefaultAssetBundle.of(context)
  //       .loadString("assets/right_eye_model.json");
  //   final model = LinearRegressor.fromJson(json);
  //   final tester = DataFrame([
  //     [
  //       "left_eye_distance",
  //       'right_eye_distance',
  //       "both_eye_distance",
  //       "left_fontsize",
  //       "right_fontsize",
  //       "both_eye_fontsize"
  //     ],
  //     [
  //       widget.data[0]["distance"],
  //       widget.data[1]["distance"],
  //       widget.data[2]["distance"],
  //       widget.data[0]["fontsize"],
  //       widget.data[1]["fontsize"],
  //       widget.data[2]["fontsize"],
  //     ]
  //   ]);
  //   final prediction = model.predict(tester);
  //   return (prediction.rows.first.first).toStringAsFixed(3);
  // }

  // Future getdiagonis() async {
  //   var json = await DefaultAssetBundle.of(context)
  //       .loadString("assets/diagnose_model.json");
  //   final model = LinearRegressor.fromJson(json);
  //   final tester = DataFrame([
  //     [
  //       "left_eye_distance",
  //       'right_eye_distance',
  //       "both_eye_distance",
  //       "left_fontsize",
  //       "right_fontsize",
  //       "both_eye_fontsize"
  //     ],
  //     [
  //       widget.data[0]["distance"],
  //       widget.data[1]["distance"],
  //       widget.data[2]["distance"],
  //       widget.data[0]["fontsize"],
  //       widget.data[1]["fontsize"],
  //       widget.data[2]["fontsize"],
  //     ]
  //   ]);
  //   final prediction = model.predict(tester);
  //   return (prediction.rows.first.first.ceil()).toString();
  // }
}
