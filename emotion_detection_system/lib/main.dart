import 'package:camera/camera.dart';
import 'package:emotion_detection_system/home.dart';
import 'package:flutter/material.dart';

List<CameraDescription>? camera;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  camera = await availableCameras();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}
