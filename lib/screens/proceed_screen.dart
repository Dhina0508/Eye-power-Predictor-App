import 'dart:io';

import 'package:eye_power_prediction/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eye_power_prediction/screens/output_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

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

  // List payload = [];
  setdatas() async {
    isLoading = true;
    setState(() {});
    // payload = widget.data;
    // for (int i = 0; i < payload.length; i++) {
    //   InputImage inputImage = InputImage.fromFile(File(payload[i]["path"]));
    //   Map details = await processImage(inputImage);
    //   payload[i]["details"] = details;
    //   List<Face> face = payload[i]["details"]["bounding"];
    //   Rect? bounding = face.first.boundingBox;
    //   // ignore: use_build_context_synchronously
    //   Size screenSize = MediaQuery.of(context).size;
    //   Offset boundingBoxCenter = bounding.center;

    //   // Calculate the center of the screen
    //   Offset screenCenter = Offset(screenSize.width / 2, screenSize.height / 2);

    //   // Calculate the distance from the center of the bounding box to the center of the screen
    //   double distance = calculateDistance(boundingBoxCenter, screenCenter);
    //   payload[i]["distance"] = distance;
    // }
    // dev.log(payload.toString());
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !isLoading
          ? AppBar(
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
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  )),
            )
          : null,
      body: isLoading
          ? Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset("assets/lottie/eye.json"),
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
              padding: const EdgeInsets.all(15),
              child: ListView.builder(
                  itemCount: widget.data.length,
                  itemBuilder: (ctx, i) {
                    // List<Face> face = payload[i]["details"]["bounding"];
                    // Rect? bounding = face.first.boundingBox;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(121, 208, 208, 208),
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, top: 12, bottom: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    widget.data[i]["focus"].toUpperCase(),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "FONTSIZE: ${widget.data[i]["fontsize"]}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child:
                                      Image.file(File(widget.data[i]["path"]))),
                            ],
                          ),
                        ),
                      ),
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
                  shape: const CircleBorder(),
                  backgroundColor: appcolor,
                  onPressed: () async {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => OutputScreen(
                          data: widget.data,
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

//   double calculateDistance(Offset point1, Offset point2) {
//     var result = ((point1.dx - point2.dx) * (point1.dx - point2.dx) +
//         (point1.dy - point2.dy) * (point1.dy - point2.dy));
//     return sqrt(result);
//   }

//   final FaceDetector _faceDetector = FaceDetector(
//     options: FaceDetectorOptions(
//       enableContours: true,
//       enableLandmarks: true,
//     ),
//   );
//   Future processImage(InputImage inputImage) async {
//     Map data = {};

//     final faces = await _faceDetector.processImage(inputImage);
//     if (inputImage.metadata?.size != null &&
//         inputImage.metadata?.rotation != null) {
//     } else {
//       data["no_faces"] = faces.length;
//       data["bounding"] = faces;
//     }
//     return data;
//   }
// }

// class BoundingBoxPainter extends CustomPainter {
//   BoundingBoxPainter({required this.rects});
//   Rect? rects;

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.red
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2.0;

//     // Draw bounding box
//     final rect = rects ??
//         const Rect.fromLTWH(
//             10, 10, 10, 10); // Modify the bounding box position and size
//     canvas.drawRect(rect, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
}
