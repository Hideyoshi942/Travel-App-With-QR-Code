import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ptktpm_final_project/view/Account/Login.dart';


import '../../control/Firebase_authen.dart';
import '../../control/Firebase_data_processing.dart';
import '../News_feed/News_feed.dart';

class Register extends StatelessWidget{

  final FirebaseAuthService _auth = FirebaseAuthService();
  final FireStoreService _fireStore = FireStoreService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/login.jpg"),
            fit: BoxFit.cover,
          ),

        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.only(bottom: 40, left: 5),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                          backgroundColor: Colors.orangeAccent
                      ),
                      onPressed: (){
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: Icon(Icons.arrow_back_outlined)),
                ),
                SizedBox(height: 20,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Image.asset(
                      "assets/iconLogin.png", // Đường dẫn đến biểu tượng trong thư mục assets
                      width: 200, // Thay đổi kích thước của biểu tượng theo ý muốn
                      height: 200,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Tài khoản(email)",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: _userNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Tên người dùng",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        obscureText: true,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Mật khẩu",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        obscureText: true,
                        controller: _confirmpasswordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Xác nhận mật khẩu",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightBlueAccent,
                              foregroundColor: Colors.indigo,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                          ),
                          onPressed: () async {
                            if(_emailController.text == ""){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Chưa nhập email")));
                            }
                            else if(_userNameController.text == ""){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Chưa nhập Tên người dùng")));
                            }
                            else if(_passwordController.text == ""){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Chưa nhập password")));
                            }
                            else if(_passwordController.text != _confirmpasswordController.text){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Xác nhận password không đúng")));
                            }
                            else {
                              User? user = await _auth.registerUserWithEmailAndPassword(_emailController.text, _passwordController.text);
                              if(user != null){
                                _fireStore.addData({
                                  'id' : _emailController.text,
                                  'username' : _userNameController.text,
                                  'password' : _passwordController.text,
                                }, 'Account');
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Đăng ký thành công")));
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => News_feed()),
                                );
                              }
                              else{
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Đăng ký không thành công.")));
                              }
                            }
                          },
                          child: Text("Đăng kí", style: TextStyle(fontSize: 20),),

                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}