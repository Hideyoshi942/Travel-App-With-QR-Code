import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ptktpm_final_project/services/dataprocessign.dart';
import '../../services/auth.dart';
import '../login/login.dart';

class Information extends StatefulWidget {
  String email;

  Information(this.email);

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  AuthService _auth = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  FireStoreService _store = FireStoreService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(10)
          ),
            child: Icon(Icons.logout),
            onPressed: () async {
              await GoogleSignIn().signOut();
              await _auth.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignIn(),));
            },
          ),
        ],
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                    FontAwesomeIcons.twitter,
                    size: 50,
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: 300,
                  child: TextField(
                    enabled: false,
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
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
                    enabled: false,
                    controller: _dateController,
                    decoration: InputDecoration(
                      hintText: "Ngày đăng kí tài khoản",
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
                SizedBox(height: 40,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                      onPressed: () async {
                        QuerySnapshot? query = await _store.getData("User", "email", widget.email);
                        if(query != null){
                          DocumentSnapshot document = query.docs.first;
                          _emailController.text = document["email"];
                          _nameController.text = document["name"];
                          _dateController.text = document["date"];
                          _phoneNumberController.text = document["phone_Number"];
                        }
                      }, child: Text("Xem", style: TextStyle(fontSize: 20),)),
                  SizedBox(width: 50,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                      onPressed: (){
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Xác nhận Sửa đổi thông tin cá nhân"),
                                content: Text('Bạn có chắc chắn muốn tiếp tục?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('No'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      QuerySnapshot? query = await _store.getData("User", 'email', widget.email);
                                      DocumentSnapshot? document = query?.docs.first;
                                      Map<String, dynamic> newdata = {
                                        "name" : _nameController.text,
                                        "phone_Number" : _phoneNumberController.text,
                                      };
                                      _store.updateData("User", document!.id, newdata);
                                      ScaffoldMessenger.of(context).
                                      showSnackBar(SnackBar(content: Text("thông tin cá nhân đã được cập nhật")));
                                      Navigator.of(context).pop();
                                      print('chon sua doi thong tin');
                                    },
                                    child: Text('Yes'),
                                  ),
                                ],
                              );
                            },
                        );
                      }, child: Text("Sửa", style: TextStyle(fontSize: 20),)),
                ],),
          
              ],
          ),
        ),
      ),
    );
  }
}
