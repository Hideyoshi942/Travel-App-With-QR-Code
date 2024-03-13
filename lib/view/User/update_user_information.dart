import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ptktpm_final_project/view/News_feed/News_feed.dart';
import 'package:ptktpm_final_project/view/User/User_information.dart';

import '../../control/Firebase_data_processing.dart';

class Update_user_information extends StatelessWidget{
  final FireStoreService _firestore = FireStoreService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  FireStoreService _store = FireStoreService();
  String _id_Account;
  Update_user_information(this._id_Account);

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
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Text(
                    "BỔ SUNG THÔNG TIN TÀI KHOẢN",
                    style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                  ),
                ),
                Image.asset("assets/iconInformationUser.png",width: 200,height: 200,),
                SizedBox(height: 50,),
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
                SizedBox(height: 50,),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,
                        fixedSize: Size(200, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                    onPressed: () async{
                      if(!_phoneNumberController.text.runes.every((element) => element >=48 && element<=57)){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("số điện thoại chỉ có thể là các ch số")));
                      }
                      else{
                        DateFormat dateformat = DateFormat('yyy/MM/dd');
                        String date = dateformat.format(DateTime.now());
                        QuerySnapshot query = await FirebaseFirestore.instance.collection("News_Feed").get();
                        int News_Feed_number = query.docs.length;
                        _firestore.addData({
                          'name' : _nameController.text.trim(),
                          'phone_Number' : _phoneNumberController.text.trim(),
                          'date' : date,
                          'id_Account' : _id_Account,
                          'id_News_Feed' : News_Feed_number,
                        }, "User");
                        QuerySnapshot? queryUser = await _store.getData("User", 'id_Account', _id_Account);
                        if(query != null){
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => User_information('id_Account', _id_Account),
                              )
                          );
                        }
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Thông tin đã được cập nhật")));
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
                SizedBox(height: 20,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
