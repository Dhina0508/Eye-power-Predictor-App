import 'dart:io';

import 'package:eye_power_prediction/screens/output_screen.dart';
import 'package:flutter/material.dart';

class ProceedScreen extends StatelessWidget {
  final List data;

  const ProceedScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (ctx, i) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Fontsize: ${data[i]["focus"]}",
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Image.file(File(data[i]["path"])),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Fontsize: ${data[i]["fontsize"]}",
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const Divider()
                ],
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const OutputScreen(),
            ),
          );
        },
        child: const Icon(Icons.arrow_forward_outlined),
      ),
    );
  }
}
