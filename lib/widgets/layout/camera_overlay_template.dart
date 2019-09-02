import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';

class CameraWidget extends StatefulWidget {
  static const String route = '/camera-screen';
  final String heading;
  final String body;
  final bool isRectangle;

  // ignore: avoid_positional_boolean_parameters
  const CameraWidget(this.heading, this.body, this.isRectangle);

  @override
  CameraState createState() => CameraState(heading, body, isRectangle);
}

class CameraState extends State<CameraWidget> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<CameraDescription> cameras;
  CameraController controller;
  bool isReady = false;
  bool showCamera = true;
  String imagePath;

  final String heading;
  final String body;
  final bool isRectangle;

  // ignore: avoid_positional_boolean_parameters
  CameraState(this.heading, this.body, this.isRectangle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          color: Colors.black26,
          child: Container(
            decoration:
                BoxDecoration(color: Colors.black26),
            height: showCamera ? 175 : 75,
            child: showCamera
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        heading,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.00,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Text(
                          body,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.00,
                          ),
                        ),
                      ),
                      captureControlRowWidget()
                    ],
                  )
                : editCaptureControlRowWidget(),
          ),
        ),
        backgroundColor: Colors.black26,
        key: scaffoldKey,
        body: showCamera
            ? isRectangle
                ? Stack(
                    children: <Widget>[
                      cameraPreviewWidget(),
                      Center(
                        child: ClipOval(
                          child: Container(
                            color: Colors.white12,
                            height: 380,
                            width: 275,
                          ),
                        ),
                      )
                    ],
                  )
                : Stack(children: <Widget>[
                    cameraPreviewWidget(),
                    Center(
                      child: Container(
                        color: Colors.white12,
                        height: 275,
                        width: 380,
                      ),
                    )
                  ])
            : imagePreviewWidget());
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  @override
  void initState() {
    super.initState();
    setupCameras();
  }

  Future<void> setupCameras() async {
    try {
      cameras = await availableCameras();
      controller = new CameraController(cameras[0], ResolutionPreset.ultraHigh);
      await controller.initialize();
    } on CameraException catch (_) {
      setState(() {
        isReady = false;
      });
    }
    setState(() {
      isReady = true;
    });
  }

  Future<String> takePicture() async {
    if (!controller.value.isInitialized) {
      return null;
    }
    final extDir = await getApplicationDocumentsDirectory();
    final dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final filePath = '$dirPath/${timestamp()}.jpg';

    if (controller.value.isTakingPicture) {
      return null;
    }

    try {
      await controller.takePicture(filePath);
    } on CameraException {
      return null;
    }
    return filePath;
  }

  void onTakePictureButtonPressed() {
    takePicture().then((String filePath) {
      if (mounted) {
        setState(() {
          showCamera = false;
          imagePath = filePath;
        });
      }
    });
  }

  Widget cameraPreviewWidget() {
    if (!isReady || !controller.value.isInitialized) {
      return Container();
    }
    return CameraPreview(controller);
  }

  Widget imagePreviewWidget() {
    final size = MediaQuery.of(context).size;
    return Scaffold(body: Center(child: imagePath == null ? null : Image.file(File(imagePath), width: size.width, height: size.height, fit: BoxFit.fill,)));
  }

  Widget captureControlRowWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.radio_button_unchecked),
          color: Colors.white,
          iconSize: 60,
          onPressed: controller != null && controller.value.isInitialized
              ? onTakePictureButtonPressed
              : null,
        ),
      ],
    );
  }

  Widget editCaptureControlRowWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            iconSize: 45,
            onPressed: () => setState(() {
                  showCamera = true;
                })),
        IconButton(
          icon: const Icon(Icons.check),
          color: Colors.white,
          iconSize: 45,
        ),
      ],
    );
  }
}
