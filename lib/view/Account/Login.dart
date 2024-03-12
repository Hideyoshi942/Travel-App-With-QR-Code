import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ptktpm_final_project/view/News_feed/News_feed.dart';
import '../../control/Firebase_authen.dart';
import './Register.dart';

class Login extends StatelessWidget{
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return News_feed();
          }
          else{
            return Scaffold(
              body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/login.jpg"),
                    fit: BoxFit.cover,
                  ),

                ),
                child: Center(
                  child: Column(
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
                              else if(_passwordController.text == ""){
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Chưa nhập password")));
                              }
                              else{
                                User? user = await _auth.loginUserWithEmailAndPassword(_emailController.text, _passwordController.text);
                                if(user != null){
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Đăng nhập thành công")));
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => News_feed(),));
                                  _emailController.clear();
                                  _passwordController.clear();
                                }
                                else{
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Đăng nhập không thành công")));
                                }
                              }
                            },
                            child: Text("Đăng nhập", style: TextStyle(fontSize: 20),),

                          ),
                          SizedBox(
                            width: 40,
                          ),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightBlueAccent,
                                foregroundColor: Colors.indigo,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                            ),
                            onPressed: (){
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Register()),
                              );
                            },
                            child: Text("Đăng kí", style: TextStyle(fontSize: 20),),

                          ),


                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        },
    );

  }
}
