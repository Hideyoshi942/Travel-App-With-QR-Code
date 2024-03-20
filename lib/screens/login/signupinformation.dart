import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ptktpm_final_project/screens/home/mainhomepage.dart';
import 'package:ptktpm_final_project/screens/user/information.dart';
import 'package:ptktpm_final_project/services/dataprocessign.dart';

class SignUpInformation extends StatefulWidget{
  String email;

  SignUpInformation(this.email);

  @override
  State<StatefulWidget> createState() {
    return SignUpInformationState();
  }

}

class SignUpInformationState extends State<SignUpInformation>{
  final TextEditingController _fullNameController = TextEditingController();

  final TextEditingController _dateOfBirthController = TextEditingController();

  final TextEditingController _genderController = TextEditingController();

  final TextEditingController _hometownController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneNumberController = TextEditingController();
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
            Text("Thông Tin Cá Nhân", style: TextStyle(color: Colors.white, fontSize: 30),),
            SizedBox(height: 30),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _fullNameController,
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
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              Map<String, dynamic> data = {
                'name': _fullNameController.text,
                'date': DateFormat('yyyy/MM/dd')
                    .format(DateTime.now()),
                'gender': _genderController.text,
                'address': _hometownController.text,
                'email': widget.email,
                'phone_Number': _phoneNumberController.text,
              };
              _store.addData(data, "User");
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Cập nhật dữ liệu thành công")));
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainHomePage(widget.email),));
            }, child: Text("Cập Nhật", style: TextStyle(fontSize: 30, color: Colors.blue),))
          ],
        ),
      ),
    );
  }
}