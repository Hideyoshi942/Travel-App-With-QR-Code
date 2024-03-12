import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../control/Firebase_authen.dart';

class News_feed extends StatelessWidget {
  FirebaseAuthService _auth = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [ElevatedButton(onPressed: () async {
        await _auth.SignOut();
        Navigator.of(context).popAndPushNamed("/");
      }, child: Icon(Icons.logout))]),
      body: Center(
        child: Container(
          child: Text("hello", style: TextStyle(fontSize: 40),),
        ),
      ),
    );
  }
}
