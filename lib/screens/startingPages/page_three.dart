import 'package:flutter/material.dart';

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Enjoy the convenience!",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: Colors.black),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
              width: width * 0.9,
              height: height * 0.1,
              child: const Text(
                "We'll take care of the rest.",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff3A3A3A)),
              )),
          SizedBox(
            height: height * 0.05,
          ),
         
        ],
      ),
    );
  }
}
