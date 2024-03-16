import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:syncfusion_flutter_sliders/sliders.dart';

class PhotoScreen extends StatefulWidget {
  final List<CameraDescription> camera;

  const PhotoScreen({super.key, required this.camera});

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  late CameraController controller;

  // switching camera
  bool isCapturing = false;
  int _selectedCameraIndex = 0;
  bool _isFrontCamera = false;

  // for flash
  bool _isFlash = false;

  // for focusing
  Offset? _focusPoint;

  // for zoom
  double _currentZoom = 1.0;
  File? _capturedImage;

  // for makeing sound
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.camera[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _toggleFlashLight() {
    if (_isFlash) {
      controller.setFlashMode(FlashMode.off);
      setState(() {
        _isFlash = false;
      });
    } else {
      controller.setFlashMode(FlashMode.torch);
      setState(() {
        _isFlash = true;
      });
    }
  }

  void _switchCamera() async {
    if (controller != null) {
      //dispose the current controller to release the camera resource
      await controller.dispose();
    }

    // increment or reset the selected camera index
    _selectedCameraIndex = (_selectedCameraIndex + 1) % widget.camera.length;

    // initialize the new camera
    _initCamera(_selectedCameraIndex);
  }

  Future<void> _initCamera(int cameraIndex) async {
    controller =
        CameraController(widget.camera[cameraIndex], ResolutionPreset.max);

    try {
      await controller.initialize();
      setState(() {
        if (cameraIndex == 0) {
          _isFrontCamera = false;
        } else {
          _isFrontCamera = true;
        }
      });
    } catch (e) {
      print("Error message: ${e}");
    }

    if (mounted) {
      setState(() {});
    }
  }

  void capturePhoto() async {
    if (!controller.value.isInitialized) {
      return;
    }

    final Directory appDir = await pathProvider.getApplicationSupportDirectory();
    final String capturePath = path.join(appDir.path, "${DateTime.now()}.jpg");

    if (controller.value.isTakingPicture) {
      return;
    }

    try {
      setState(() {
        isCapturing = true;
      });
      final XFile capturedImage = await controller.takePicture();
      String imagePath = capturedImage.path;
      await GallerySaver.saveImage(imagePath);
      print("Photo captured abd saved to the gallery");
      
      // play a sound effect
      audioPlayer.open(Audio("assets/camera/camera_shutter.mp3"));
      audioPlayer.play();

      // showing image

      final String filePath = '$capturePath/${DateTime.now().microsecondsSinceEpoch}.jpg';
      _capturedImage = File(capturedImage.path);
      _capturedImage!.renameSync(filePath);
    } catch (e) {
      print("Error capturing photo: $e");
    } finally {
      setState(() {
        isCapturing = false;
      });
    }
  }

  void zoomCamera(double value) {
    setState(() {
      _currentZoom = value;
      controller.setZoomLevel(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(color: Colors.black),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                            onTap: () {
                              _toggleFlashLight();
                            },
                            child: _isFlash == false
                                ? Icon(
                                    Icons.flash_off,
                                    color: Colors.white,
                                  )
                                : Icon(Icons.flash_on, color: Colors.white)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                            onTap: () {},
                            child: Icon(Icons.qr_code_scanner,
                                color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                top: 50,
                bottom: _isFrontCamera == false ? 0 : 150,
                child: AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: CameraPreview(controller),
                ),
              ),

              Positioned(
                  top: 50,
                  right: 10,
                  child: SfSlider.vertical(
                    max: 5.0,
                    min: 1.0,
                    activeColor: Colors.white,
                    value: _currentZoom,
                    onChanged: (dynamic value) {
                      setState(() {
                        zoomCamera(value);
                      });
                    },
                  )
              ),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                      color: _isFrontCamera == false
                          ? Colors.black45
                          : Colors.black),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  "Video",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  "Photo",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  "Pro Mode",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      _capturedImage != null ? Container(
                                        width: 50,
                                        height: 50,
                                        child: Image.file(_capturedImage!, fit: BoxFit.cover,),
                                      ) : Container(),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      capturePhoto();
                                    },
                                    child: Center(
                                      child: Container(
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                            width: 4,
                                            color: Colors.white,
                                            style: BorderStyle.solid,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      _switchCamera();
                                    },
                                    child: Icon(
                                      Icons.cameraswitch_sharp,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
