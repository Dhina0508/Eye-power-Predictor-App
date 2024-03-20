import 'package:camera/camera.dart';
import 'package:eye_power_prediction/screens/startingPages/main_page.dart';
import 'package:eye_power_prediction/screens/take_picture.dart';
import 'package:flutter/material.dart';

List<CameraDescription> cameras = [];
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      // home: const MyHomePage(title: 'EYE POWER PREDICTOR'),
      home: LandingScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // void _incrementCounter() {
  //   setState(() {
  //     fontSize++;
  //   });
  // }

  // void _decrimentCounter() {
  //   setState(() {
  //     fontSize--;
  //   });
  // }

  // double fontSize = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.remove_red_eye_outlined),
            SizedBox(
              width: 10,
            ),
            Text(
              widget.title,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(25.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(156, 241, 170, 247)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Text(
                    'To Predict the eye power, please hold the phone away from your face, then try to increase the size of the font by using the below buttons. When you feel hard to read the text,please take a selfie of your face with proper lighting.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(20.0),
            //   child: Text(
            //     "Hi I'm your virtual eye doctor!!",
            //     textAlign: TextAlign.center,
            //     style:
            //         TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
            //   ),
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     FloatingActionButton(
            //       onPressed: _decrimentCounter,
            //       heroTag: "btn_1",
            //       tooltip: 'reduce',
            //       child: const Icon(Icons.remove),
            //     ),
            //     FloatingActionButton(
            //       heroTag: "btn_2",
            //       onPressed: _incrementCounter,
            //       tooltip: 'Increment',
            //       child: const Icon(Icons.add),
            //     ),
            //   ],
            // )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "btn_3",
        onPressed: () {
          int idx = cameras.indexWhere(
              (element) => element.lensDirection == CameraLensDirection.front);
          if (idx == -1) {
            idx = 0;
          }
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      TakePictureScreen(fontSize: 0, camera: cameras[idx])));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
