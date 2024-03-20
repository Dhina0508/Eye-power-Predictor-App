import 'package:flutter/material.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Easy to Book",
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
                "Enjoy a suite of personalized services, from gourmet dining and immaculate laundry care to nutritious tiffin meals and homemaking expertise, all designed to enhance your everyday life.",
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
