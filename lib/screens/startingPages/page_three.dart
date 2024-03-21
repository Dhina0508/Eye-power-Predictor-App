import 'package:flutter/material.dart';

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Selfie Prompt",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
                width: width * 0.9,
                child: const Text(
                  "If you find it hard to read the text, please take a selfie of your face with proper lighting.",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff3A3A3A)),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 40),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  "assets/images/s3.jpg",
                  height: height * 0.6,
                  fit: BoxFit.cover,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
