import 'package:flutter/material.dart';
import 'package:flutter_avif/flutter_avif.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Font Size Adjustment",
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
                  "Try to increase or decrease the size of the font by using the buttons",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff3A3A3A)),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 40),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: AvifImage.asset(
                  "assets/images/s2.avif",
                  height: height * 0.6,
                  fit: BoxFit.contain,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
