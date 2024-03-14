import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ptktpm_final_project/view/News_feed/News_feed.dart';
import 'package:ptktpm_final_project/view/User/User_information.dart';
import 'package:ptktpm_final_project/view/User/update_user_information.dart';
import '../../control/Firebase_authen.dart';
import '../../control/Firebase_data_processing.dart';
import './Register.dart';

class Login extends StatelessWidget{
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  FireStoreService _store = FireStoreService();

  Future<String?> signInWithGoogle() async{
    GoogleSignInAccount? googleUSer = await GoogleSignIn().signIn();
    String? email = googleUSer?.email;
    GoogleSignInAuthentication? googleAuth = await googleUSer?.authentication;

    AuthCredential credential =  GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    return email;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            User? user = snapshot.data;
            String? id_Account = user?.email;
            return News_Feed(_store.getData("User", "id_Account", id_Account));
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
                              String id_News_Feed = "";
                              if(_emailController.text == ""){
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Chưa nhập email")));
                              }
                              else if(_passwordController.text == ""){
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Chưa nhập password")));
                              }
                              else{
                                User? user = await _auth.loginUserWithEmailAndPassword(_emailController.text, _passwordController.text);
                                if(user != null){
                                  String id_Acount = _emailController.text;
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Đăng nhập thành công")));
                                  Navigator.pushReplacement(
                                      context, MaterialPageRoute(
                                    builder: (context) => News_Feed(_store.getData("User", "id_Account", id_Acount)),));
                                  _emailController.clear();
                                  _passwordController.clear();

                                }
                                else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Đăng nhập không thành công")));
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
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightBlueAccent,
                              foregroundColor: Colors.indigo,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                          ),

                          onPressed: () async {
                            String? email = await signInWithGoogle();
                            QuerySnapshot? query = await _store.getData("Account", "id", email);
                            if(query?.size == 0){
                              _store.addData({
                                'id' : email,
                                'password' : "",
                                'username' : email,
                              }, 'Account');
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Update_user_information(email!),));
                            }
                            else{
                              DocumentSnapshot? document = query?.docs.first;
                              if(document != null){
                                String id_Account = document["id_Account"];

                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => News_Feed(
                                          _store.getData("User", "id_Account", id_Account)
                                      ),
                                    )
                                );
                              }
                            }
                          },
                          icon: FaIcon(FontAwesomeIcons.google),
                          label: Text("Đăng Nhập Bằng Google", style: TextStyle(fontSize: 20)),
                      ),
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
