import 'dart:developer';
import 'dart:io';

import 'package:eye_power_prediction/model/prediction_model.dart';
import 'package:eye_power_prediction/screens/startingPages/main_page.dart';
import 'package:eye_power_prediction/service/api_service.dart';
import 'package:eye_power_prediction/service/firebase_service.dart';
import 'package:eye_power_prediction/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_avif/flutter_avif.dart';
import 'package:lottie/lottie.dart';

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
      appBar: !isError && !isLoading
          ? AppBar(
              title: Text(
                "YOUR REPORT",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  )),
              centerTitle: true,
              backgroundColor: appcolor,
            )
          : null,
      body: isError
          ? Center(
              child: Text(error),
            )
          : isLoading
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          "assets/lottie/eye.json",
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Please wait while we analyze your data....",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        )
                      ],
                    ),
                  ),
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            textAlign: TextAlign.center,
                            pm!.diagnosis![0] == 'normal'
                                ? "Your Eyesight Appears to be Normal"
                                : "You might have ${pm!.diagnosis![0]},  Please contact a Doctor for further Evaluation",
                            style: const TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 23)),
                        const SizedBox(
                          height: 20,
                        ),
                        pm!.diagnosis![0] == 'normal'
                            ? Image.asset("assets/images/noSpecs.png")
                            : AvifImage.asset(
                                "assets/images/specs.avif",
                              ),
                        const SizedBox(
                          height: 25,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Left Eye Power: ${pm!.leftPower![0].toStringAsFixed(3)}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 21)),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                                "Right Eye Power: ${pm!.rightPower![0].toStringAsFixed(3)}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 21)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
      bottomNavigationBar: !isLoading
          ? SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LandingScreen()),
                            (route) => false);
                      },
                      child: Text(
                        "OK >>>",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: appcolor),
                      )),
                  SizedBox(
                    width: 30,
                  )
                ],
              ),
            )
          : Container(
              height: 1,
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
