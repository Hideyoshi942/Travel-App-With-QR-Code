import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ptktpm_final_project/screens/login/login.dart';
import 'package:ptktpm_final_project/screens/login/signupinformation.dart';
import 'package:ptktpm_final_project/screens/tour/showTour.dart';
import 'package:ptktpm_final_project/screens/user/profile.dart';
import 'package:ptktpm_final_project/services/auth.dart';
import 'package:ptktpm_final_project/services/dataprocessign.dart';

class Information extends StatefulWidget {
  String email;

  Information(this.email);
  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  AuthService _auth = AuthService();
  FireStoreService _service = FireStoreService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            color: Colors.deepOrange,
            child: Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.symmetric(horizontal: 10,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    child: Icon(Icons.person), // Thay đổi thành hình ảnh của người dùng
                  ),
                  SizedBox(width: 10),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tôi', // Thay đổi thành tên của người dùng
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Thành viên', // Thay đổi thành tên của người dùng
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Đơn hàng của tôi'),
            onTap: () async{
              QuerySnapshot? queryUser = await _service.getData("User", "email", widget.email);
              String idTour = queryUser?.docs.first["idTour"];
              DocumentSnapshot document = await FirebaseFirestore.instance.collection("Tour").
              doc("EtY6L9CkRc3j7j8zn7C1").collection("featureproduct").doc(idTour).get();
              String address, image, name;
              double price;
              address = document["address"];
              image = document["image"];
              name = document["name"];
              price = document["price"];
              Navigator.push(context, MaterialPageRoute(builder: (context) => ShowTour(address, image, name, price),));
              // Xử lý khi người dùng chọn tùy chọn này
            },
          ),
          ListTile(
            leading: Icon(Icons.paste_rounded),
            title: Text('Thông tin cá nhân'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile(widget.email)));
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Thông báo'),
            onTap: () {
              // Xử lý khi người dùng chọn tùy chọn này
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Cài đặt'),
            onTap: () {
              // Xử lý khi người dùng chọn tùy chọn này
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Trợ giúp và hỗ trợ'),
            onTap: () {
              // Xử lý khi người dùng chọn tùy chọn này
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Đăng xuất'),
            onTap: () async {
              await _auth.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignIn(),));
            },
          ),
        ],
      ),
    );
  }
}
