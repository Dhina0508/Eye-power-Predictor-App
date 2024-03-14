import 'dart:async';

import 'package:camera/camera.dart';
import 'package:eye_power_prediction/screens/proceed_screen.dart';
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

  double fontSize = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture')),
      body: Stack(
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
              "Hi I'm your virtual eye doctor!!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  backgroundColor: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 25,
            child: Text(
              data.isEmpty
                  ? "Close your right Eye."
                  : data.length == 1
                      ? "Close your left Eye."
                      : "use both Eyes.",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  backgroundColor: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              onPressed: _decrimentCounter,
              heroTag: "btn_1",
              tooltip: 'reduce',
              child: const Icon(Icons.remove),
            ),
            FloatingActionButton(
              heroTag: "btn_2",
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
            FloatingActionButton(
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
                  fontSize = 30;
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
                  print(e);
                }
              },
              child: const Icon(Icons.camera_alt),
            )
          ],
        ),
      ),
    );
  }
}
