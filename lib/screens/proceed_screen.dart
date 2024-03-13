import 'dart:io';

import 'package:eye_power_prediction/screens/output_screen.dart';
import 'package:flutter/material.dart';

class ProceedScreen extends StatelessWidget {
  final String imagePath;
  final double fontSize;

  const ProceedScreen(
      {super.key, required this.imagePath, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.file(File(imagePath)),
          const SizedBox(
            height: 25,
          ),
          Text(
            "Fontsize: $fontSize",
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => OutputScreen(
                fontSize: fontSize,
                imagePath: imagePath,
              ),
            ),
          );
        },
        child: const Icon(Icons.arrow_forward_outlined),
      ),
    );
  }
}
