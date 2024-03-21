import 'package:flutter/material.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

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
              "Welcome Back !!!",
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
                  "To predict the Eye Power, Hold the mobile away from your face.",
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
                  "assets/images/s1.jpg",
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
