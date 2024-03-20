import 'package:camera/camera.dart';
import 'package:eye_power_prediction/main.dart';
import 'package:eye_power_prediction/screens/startingPages/page_one.dart';
import 'package:eye_power_prediction/screens/startingPages/page_three.dart';
import 'package:eye_power_prediction/screens/startingPages/page_two.dart';
import 'package:eye_power_prediction/screens/take_picture.dart';
import 'package:eye_power_prediction/utils/colors.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  static const routePath = "/landing_page";
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  PageController? pageController;
  int currentPage = 0;
  @override
  void initState() {
    super.initState();
    getInitData();
  }

  @override
  void dispose() {
    super.dispose();
    pageController?.dispose();
  }

  getInitData() async {
    pageController = PageController();
  }

  final List<Widget> _pages = [
    const PageOne(),
    const PageTwo(),
    const PageThree(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List<Widget>.generate(
                      _pages.length,
                      (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: Container(
                            height: currentPage == index ? 9 : 8,
                            width: currentPage == index ? 40 : 6,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: currentPage == index
                                    ? appcolor
                                    : const Color(0xffD9D9D9)),
                          )),
                    )),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 30),
                  child: PageView.builder(
                      controller: pageController,
                      itemCount: _pages.length,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (int page) {
                        setState(() {
                          currentPage = page;
                        });
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return _pages[currentPage];
                      }),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
          child: InkWell(
            onTap: () {
              if (currentPage == 2) {
                int idx = cameras.indexWhere((element) =>
                    element.lensDirection == CameraLensDirection.front);
                if (idx == -1) {
                  idx = 0;
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TakePictureScreen(
                            fontSize: 0, camera: cameras[idx])));
              } else {
                pageController!.animateToPage(
                  currentPage + 1,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.linear,
                );
              }
            },
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30), color: appcolor),
                height: 46,
                child: const Center(
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                )),
          ),
        ));
  }
}
