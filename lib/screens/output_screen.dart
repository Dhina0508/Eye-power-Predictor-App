import 'package:flutter/material.dart';
import 'package:ml_algo/ml_algo.dart';
import 'package:ml_dataframe/ml_dataframe.dart';

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

  bool isLoading = true;
  loadData() async {
    left = await getleftEyePower();
    right = await getrightEyePower();
    diagonis = await getdiagonis();
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
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
                      Text("Left eye: $left",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      Text("right eye: $right",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      Text(
                          "you might have: ${diagonis == "1" ? "Myopia" : diagonis == "2" ? "Hypermyopiya" : "Normal"}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                    ],
                  )
                ],
              ),
            ),
    );
  }

  Future getleftEyePower() async {
    var json = await DefaultAssetBundle.of(context)
        .loadString("assets/left_eye_model.json");
    final model = LinearRegressor.fromJson(json);
    final tester = DataFrame([
      [
        "left_eye_distance",
        'right_eye_distance',
        "both_eye_distance",
        "left_fontsize",
        "right_fontsize",
        "both_eye_fontsize"
      ],
      [
        widget.data[0]["distance"],
        widget.data[1]["distance"],
        widget.data[2]["distance"],
        widget.data[0]["fontsize"],
        widget.data[1]["fontsize"],
        widget.data[2]["fontsize"],
      ]
    ]);
    final prediction = model.predict(tester);
    return (prediction.rows.first.first).toStringAsFixed(3);
  }

  Future getrightEyePower() async {
    var json = await DefaultAssetBundle.of(context)
        .loadString("assets/right_eye_model.json");
    final model = LinearRegressor.fromJson(json);
    final tester = DataFrame([
      [
        "left_eye_distance",
        'right_eye_distance',
        "both_eye_distance",
        "left_fontsize",
        "right_fontsize",
        "both_eye_fontsize"
      ],
      [
        widget.data[0]["distance"],
        widget.data[1]["distance"],
        widget.data[2]["distance"],
        widget.data[0]["fontsize"],
        widget.data[1]["fontsize"],
        widget.data[2]["fontsize"],
      ]
    ]);
    final prediction = model.predict(tester);
    return (prediction.rows.first.first).toStringAsFixed(3);
  }

  Future getdiagonis() async {
    var json = await DefaultAssetBundle.of(context)
        .loadString("assets/diagnose_model.json");
    final model = LinearRegressor.fromJson(json);
    final tester = DataFrame([
      [
        "left_eye_distance",
        'right_eye_distance',
        "both_eye_distance",
        "left_fontsize",
        "right_fontsize",
        "both_eye_fontsize"
      ],
      [
        widget.data[0]["distance"],
        widget.data[1]["distance"],
        widget.data[2]["distance"],
        widget.data[0]["fontsize"],
        widget.data[1]["fontsize"],
        widget.data[2]["fontsize"],
      ]
    ]);
    final prediction = model.predict(tester);
    return (prediction.rows.first.first.ceil()).toString();
  }
}
