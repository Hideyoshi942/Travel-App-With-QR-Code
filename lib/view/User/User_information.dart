import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ptktpm_final_project/view/News_feed/News_feed.dart';

import '../../control/Firebase_data_processing.dart';

class User_information extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return User_information_state();
  }

  String _nameField;
  var _valueField;

  User_information(this._nameField, this._valueField);
}

class User_information_state extends State<User_information>{
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _idAccountController = TextEditingController();
  late String _id_NewsFeed;
  FireStoreService _store = FireStoreService();

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cập nhật'),
          content: Text('Bạn xác nhận muốn thay đổi thông tin'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Đóng hộp thoại và trả về false
              },
              child: Text('Không'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Đóng hộp thoại và trả về true
              },
              child: Text('Xác nhận'),
            ),
          ],
        );
      },
    ).then((confirmed) async {
      if (confirmed != null && confirmed) {
        Map<String, dynamic> update = {
          "name" : _nameController.text.trim(),
          "phone_Number" : _phoneNumberController.text.trim(),
        };
        _store.updateData("User", _idController.text, update);
        print('User confirmed.');
      } else {
        // Xử lý khi người dùng không xác nhận
        print('User canceled.');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/user_information.webp"),
                fit: BoxFit.cover
            )
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(5),
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.black87,
                        ),
                        onPressed: () async {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => News_Feed(_store.getData("User", widget._nameField, widget._valueField)),));

                        },
                        child: Icon(Icons.close,size: 40, color: Colors.yellow,)
                    )
                  ],
                ),
                Image.asset("assets/iconInformationUser.png",width: 200,height: 200,),
                SizedBox(height: 20,),
                SizedBox(
                  width: 300,
                  child: TextField(
                    enabled: false,
                    controller: _idController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "ID",
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                SizedBox(
                  width: 300,
                  child: TextField(
                    enabled: false,
                    controller: _dateController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Ngày Đăng Ký",
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Tên",
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: _phoneNumberController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Số điện thoại",
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                SizedBox(
                  width: 300,
                  child: TextField(
                    enabled: false,
                    controller: _idAccountController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Id Account",
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,
                            fixedSize: Size(150, 50),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                        onPressed: () async{
                            QuerySnapshot? query = await _store.getData("User", widget._nameField, widget._valueField);
                            if(query != null){
                              DocumentSnapshot document = query.docs.first;
                              _idController.text = document.id;
                              _dateController.text = document["date"];
                              _nameController.text = document["name"];
                              _phoneNumberController.text = document["phone_Number"];
                              _idAccountController.text = document["id_Account"];
                            }
                            else{
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Không lấy được dữ liệu")));
                            }
                    }, child: Text("XEM", style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown),)),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,
                            fixedSize: Size(150, 50),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                        onPressed: () async{
                          if(_phoneNumberController.text.length == 0 && !_phoneNumberController.text.runes.every((element) => element >=48 && element<=57)){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("số điện thoại chỉ có thể là các chữ số")));
                          }
                          else if(_nameController.text.length == 0){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Chưa nhập tên")));
                          }
                          else{
                            _showConfirmationDialog(context);
                          }
                        },
                        child: Text(
                          "CẬP NHẬT",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown),
                        )
                    ),
                  ],
                ),
                SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}