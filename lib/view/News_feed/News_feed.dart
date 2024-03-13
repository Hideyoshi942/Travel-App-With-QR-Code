import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ptktpm_final_project/view/User/User_information.dart';

import '../../control/Firebase_authen.dart';
import '../Account/Login.dart';
import '../User/update_user_information.dart';

class News_feed extends StatelessWidget {
  FirebaseAuthService _auth = FirebaseAuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [ElevatedButton(onPressed: () async {
        await _auth.SignOut();
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login(),));
      }, child: Icon(Icons.logout)),
        ElevatedButton(onPressed: () async {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => User_information("id_News_Feed", 1),));
        }, child: Icon(Icons.person)),
      ]),
      body: Center(
        child: Container(
          child: Text("hello", style: TextStyle(fontSize: 40),),
        ),
      ),
    );
  }
}
