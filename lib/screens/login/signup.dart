import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ptktpm_final_project/model/Account.dart';
import 'package:ptktpm_final_project/screens/login/login.dart';
import 'package:ptktpm_final_project/services/auth.dart';
import 'package:ptktpm_final_project/services/dataprocessign.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExp = new RegExp(p);

bool obserText = true;

class _SignUpState extends State<SignUp> {
  final AuthService _auth = new AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final FireStoreService _fireStore = FireStoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    'Đăng ký',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // Container(
                //   width: 300,
                //   child: TextFormField(
                //     controller: _userNameController,
                //     style: TextStyle(color: Colors.white),
                //     validator: (value) {
                //       if (value == "") {
                //         return "Vui lòng nhập tên người dùng";
                //       } else if (value!.length < 6) {
                //         return "Mật khẩu quá ngắn";
                //       }
                //       return "";
                //     },
                //     decoration: InputDecoration(
                //       hintText: 'Tên người dùng',
                //       hintStyle: TextStyle(
                //           color: Colors.white70, fontWeight: FontWeight.normal),
                //     ),
                //   ),
                // ),
                Container(
                  width: 300,
                  child: TextFormField(
                    controller: _emailController,
                    style: TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == "") {
                        return "Vui lòng nhập email";
                      } else if (!regExp.hasMatch(value.toString())) {
                        return "Email không chính xác";
                      }
                      return "";
                    },
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                Container(
                  width: 300,
                  child: TextFormField(
                    controller: _passwordController,
                    style: TextStyle(color: Colors.white),
                    obscureText: obserText,
                    validator: (value) {
                      if (value == "") {
                        return "Vui lòng nhập mật khẩu";
                      } else if (value!.length < 8) {
                        return "Mật khẩu quá ngắn";
                      }
                      return "";
                    },
                    decoration: InputDecoration(
                      hintText: 'Mật khẩu',
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            obserText = !obserText;
                          });
                          FocusScope.of(context).unfocus();
                        },
                        child: Icon(
                          obserText == true ? Icons.visibility : Icons.visibility_off,
                          color: Colors.white70,
                        ),
                      ),
                      hintStyle: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                // Container(
                //   width: 300,
                //   child: TextFormField(
                //     controller: _phoneNumberController,
                //     style: TextStyle(color: Colors.white),
                //     validator: (value) {
                //       if (value == "") {
                //         return "Vui lòng nhập số điện thoại";
                //       } else if (value!.length != 10) {
                //         return "Số điện thoại không chính xác";
                //       } else if (value[0] != 0) {
                //         return "Số điện thoại không chính xác";
                //       }
                //       return "";
                //     },
                //     decoration: InputDecoration(
                //       hintText: 'Số điện thoại',
                //       hintStyle: TextStyle(
                //           color: Colors.white70, fontWeight: FontWeight.normal),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () async {
                        User? user = await _auth.registerUserWithEmailAndPassword(_emailController.text, _passwordController.text);
                        if(user != null){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Đăng ký thành công")));
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignIn(),
                              ),
                          );
                          _emailController.clear();
                          _passwordController.clear();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Đăng ký không thành công")));
                        }
                    },
                    child: Text(
                      'Đăng ký',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 40),
                      child: Text('Bạn đã có tài khoản?', style: TextStyle(color: Colors.white70),),
                    ),
                    Container(
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
                          },
                          child: Text('Đăng nhập', style: TextStyle(color: Colors.amberAccent, fontSize: 16, fontWeight: FontWeight.bold),)
                      ),
                    ),
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
