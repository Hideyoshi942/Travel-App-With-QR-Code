import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ptktpm_final_project/services/dataprocessign.dart';

import 'information.dart';

class SignUpInformation extends StatefulWidget{
  String email;

  SignUpInformation(this.email);

  @override
  State<StatefulWidget> createState() {
    return SignUpInformationState();
  }

}

class SignUpInformationState extends State<SignUpInformation>{
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  FireStoreService _store = FireStoreService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Cập Nhật Thông Tin Cá Nhân", style: TextStyle(color: Colors.white, fontSize: 30),),
            Icon(
              FontAwesomeIcons.twitter,
              size: 50,
            ),
            SizedBox(height: 30),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: "Tên",
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white, // Màu nền của TextField
                ),
              ),
            ),
            SizedBox(height: 40,),

            SizedBox(
              width: 300,
              child: TextField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  hintText: "Số điện thoại",
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white, // Màu nền của TextField
                ),
              ),
            ),
            
            ElevatedButton(onPressed: (){
              Map<String, dynamic> data = {
                'name' : _nameController.text,
                'email' : widget.email,
                'phone_Number' : _phoneNumberController.text,
                'date' : DateFormat('yyyy/MM/dd').format(DateTime.now()),
              };
              _store.addData(data, "User");
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("ập nhật dữ liệu thành công")));
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Information(widget.email),));
            }, child: Text("Cập Nhật", style: TextStyle(fontSize: 30),))
          ],
        ),
      ),
    );
  }


}