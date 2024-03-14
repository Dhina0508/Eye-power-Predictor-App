import 'package:camera/camera.dart';
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
      home: const MyHomePage(title: 'Eye power predictor'),
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(25.0),
              child: Text(
                'To predict the eye power please hold the phone away from your face, then try to increase the size of the size of the font using the buttons bellow. when you feel it hard to read the text please click the camera button and take a selfi of your face with proper lighting and procceed to predict your eye power.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
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
