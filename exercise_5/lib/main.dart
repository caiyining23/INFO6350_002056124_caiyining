import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'take_picture_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  runApp(CameraApp(camera: cameras.first));
}

class CameraApp extends StatelessWidget {
  final CameraDescription camera;
  const CameraApp({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: TakePictureScreen(camera: camera),
    );
  }
}
