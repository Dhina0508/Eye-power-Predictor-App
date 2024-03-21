// ignore_for_file: avoid_print

import 'dart:async';

import 'package:camera/camera.dart';
import 'package:eye_power_prediction/screens/proceed_screen.dart';
import 'package:eye_power_prediction/utils/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    super.key,
    required this.camera,
    required this.fontSize,
  });

  final CameraDescription camera;
  final double fontSize;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();

    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  List data = [];

  @override
  void dispose() {
    _controller.dispose();
    data;
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      fontSize++;
    });
  }

  void _decrimentCounter() {
    setState(() {
      fontSize--;
    });
  }

  double fontSize = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appcolor,
        title: const Text(
          'Take a Selfie',
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
      ),
      body: Column(
        children: [
          Stack(
            children: [
              FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CameraPreview(_controller);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 25,
                child: Text(
                  "Hi I'm your Virtual Eye Doctor",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      backgroundColor: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: fontSize),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              data.isEmpty
                  ? "Close your Right Eye."
                  : data.length == 1
                      ? "Close your Left Eye."
                      : "Normal Selfie",
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              backgroundColor: appcolorLight,
              onPressed: _decrimentCounter,
              heroTag: "btn_1",
              tooltip: 'reduce',
              shape: const CircleBorder(),
              child: const Icon(Icons.remove),
            ),
            FloatingActionButton(
              backgroundColor: appcolorLight,
              heroTag: "btn_2",
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              shape: const CircleBorder(),
              child: const Icon(Icons.add),
            ),
            SizedBox(
              height: 60,
              width: 60,
              child: FloatingActionButton(
                backgroundColor: appcolor,
                onPressed: () async {
                  try {
                    await _initializeControllerFuture;

                    final image = await _controller.takePicture();

                    if (!context.mounted) return;
                    data.add({
                      "path": image.path,
                      "fontsize": fontSize,
                      "focus": data.isEmpty
                          ? "Left Eye"
                          : data.length == 1
                              ? "Right Eye"
                              : "Both Eye"
                    });
                    fontSize = 20;
                    setState(() {});
                    if (data.length == 3) {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProceedScreen(
                            data: data,
                          ),
                        ),
                      );
                    }
                  } catch (e) {
                    if (kDebugMode) {
                      print(e);
                    }
                  }
                },
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
