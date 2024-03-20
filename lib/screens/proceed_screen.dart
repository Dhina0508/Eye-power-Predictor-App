import 'dart:developer' as dev;
import 'dart:io';
import 'dart:math';

import 'package:eye_power_prediction/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:eye_power_prediction/screens/output_screen.dart';

class ProceedScreen extends StatefulWidget {
  final List data;

  const ProceedScreen({super.key, required this.data});

  @override
  State<ProceedScreen> createState() => _ProceedScreenState();
}

class _ProceedScreenState extends State<ProceedScreen> {
  @override
  void initState() {
    super.initState();
    setdatas();
  }

  bool isLoading = false;

  List payload = [];
  setdatas() async {
    isLoading = true;
    setState(() {});
    payload = widget.data;
    for (int i = 0; i < payload.length; i++) {
      InputImage inputImage = InputImage.fromFile(File(payload[i]["path"]));
      Map details = await processImage(inputImage);
      payload[i]["details"] = details;
      List<Face> face = payload[i]["details"]["bounding"];
      Rect? bounding = face.first.boundingBox;
      // ignore: use_build_context_synchronously
      Size screenSize = MediaQuery.of(context).size;
      Offset boundingBoxCenter = bounding.center;

      // Calculate the center of the screen
      Offset screenCenter = Offset(screenSize.width / 2, screenSize.height / 2);

      // Calculate the distance from the center of the bounding box to the center of the screen
      double distance = calculateDistance(boundingBoxCenter, screenCenter);
      payload[i]["distance"] = distance;
    }
    dev.log(payload.toString());
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appcolor,
        title: const Text(
          'Preview',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            )),
      ),
      body: isLoading
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(
                        strokeWidth: 8,
                        color: appcolor,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Please wait while we analyze your data....",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    )
                  ],
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: widget.data.length,
                  itemBuilder: (ctx, i) {
                    List<Face> face = payload[i]["details"]["bounding"];
                    Rect? bounding = face.first.boundingBox;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Fontsize: ${widget.data[i]["focus"]}",
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Stack(
                          children: [
                            Image.file(File(widget.data[i]["path"])),
                            Positioned.fill(
                              child: CustomPaint(
                                painter: BoundingBoxPainter(rects: bounding),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Fontsize: ${widget.data[i]["fontsize"]}",
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "No of faces: ${widget.data[i]["details"]["no_faces"]}",
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          "Distance of face: ${widget.data[i]["distance"]}",
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        const Divider()
                      ],
                    );
                  }),
            ),
      floatingActionButton: !isLoading
          ? Padding(
              padding: const EdgeInsets.only(right: 15, bottom: 10),
              child: SizedBox(
                height: 60,
                width: 60,
                child: FloatingActionButton(
                  shape: CircleBorder(),
                  backgroundColor: appcolorLight,
                  onPressed: () async {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => OutputScreen(
                          data: payload,
                        ),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.arrow_forward_outlined,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : null,
    );
  }

  double calculateDistance(Offset point1, Offset point2) {
    var result = ((point1.dx - point2.dx) * (point1.dx - point2.dx) +
        (point1.dy - point2.dy) * (point1.dy - point2.dy));
    return sqrt(result);
  }

  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: true,
      enableLandmarks: true,
    ),
  );
  Future processImage(InputImage inputImage) async {
    Map data = {};

    final faces = await _faceDetector.processImage(inputImage);
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
    } else {
      data["no_faces"] = faces.length;
      data["bounding"] = faces;
    }
    return data;
  }
}

class BoundingBoxPainter extends CustomPainter {
  BoundingBoxPainter({required this.rects});
  Rect? rects;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Draw bounding box
    final rect = rects ??
        const Rect.fromLTWH(
            10, 10, 10, 10); // Modify the bounding box position and size
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
