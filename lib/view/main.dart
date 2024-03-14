import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Account/Login.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid ?
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: 'AIzaSyC89TpjS0ux0a1H2It4VegXMs1B-ZR6ZU8',
            appId: '1:904412931568:android:58f7d57aaf7819c258e935',
            messagingSenderId: '904412931568', //project_number
            projectId: 'ptktpm-project' //project_id
        )
    ) : await Firebase.initializeApp();
  runApp(MaterialApp(home: Login(),debugShowCheckedModeBanner: false,)
  );
}