import 'dart:io';
import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ptktpm_final_project/screens/home/mainhomepage.dart';
import 'package:ptktpm_final_project/screens/home/myhomepage.dart';
import 'package:ptktpm_final_project/screens/home/welcomehome.dart';
import 'package:ptktpm_final_project/screens/login/login.dart';
import 'package:ptktpm_final_project/screens/tour/cartView.dart';
import 'package:ptktpm_final_project/screens/tour/detailView.dart';
import 'package:ptktpm_final_project/screens/tour/listTour.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: FirebaseOptions(
              apiKey: 'AIzaSyC89TpjS0ux0a1H2It4VegXMs1B-ZR6ZU8',
              appId: '1:904412931568:android:58f7d57aaf7819c258e935',
              messagingSenderId: '904412931568', //project_number
              projectId: 'ptktpm-project' //project_id
              ))
      : await Firebase.initializeApp();
  runApp(MaterialApp(
    home: SignIn(),
    debugShowCheckedModeBanner: false,
  ));
}
