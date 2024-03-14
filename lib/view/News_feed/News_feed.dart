import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ptktpm_final_project/view/User/User_information.dart';

import '../../control/Firebase_authen.dart';
import '../Account/Login.dart';
import '../User/update_user_information.dart';

class News_Feed extends StatefulWidget {
  Future<QuerySnapshot?> _id;


  News_Feed(this._id, {super.key});

  @override
  State<StatefulWidget> createState() {
    return News_Feed_State();
  }

}

class News_Feed_State extends State<News_Feed>{
  FirebaseAuthService _auth = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(onPressed: () async {
                        QuerySnapshot? query = await widget._id;
                        if(query != null){
                          String id = query.docs.first["id_News_Feed"];
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => User_information("id_News_Feed", id),));

                        }
                      }, child: Icon(Icons.person)
                    ),
                    ElevatedButton(onPressed: () async {
                      await GoogleSignIn().signOut();
                        await _auth.SignOut();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login(),));
                      }, child: Icon(Icons.logout)
                    ),
                  ],
                ),
              ),
              Text(widget._id.toString(), style: TextStyle(fontSize: 40)),
            ],
          ),
        ),
      ),
    );
  }
}
