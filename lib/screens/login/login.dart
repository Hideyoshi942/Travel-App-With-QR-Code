import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ptktpm_final_project/screens/home/mainhomepage.dart';
import 'package:ptktpm_final_project/screens/home/myhomepage.dart';
import 'package:ptktpm_final_project/screens/login/signup.dart';
import 'package:ptktpm_final_project/screens/user/information.dart';
import 'package:ptktpm_final_project/services/auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

bool obserText = true;

class _SignInState extends State<SignIn> {
  final AuthService _auth = new AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User? user = snapshot.data;
            String? id_Account = user?.email;
            return(Text("!"));
          } else {
            return Scaffold(
              backgroundColor: Colors.blue,
              body: Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 70,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child:
                        Image(image: AssetImage('assets/images/icon/logoApp.png')),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 300,
                        child: TextField(
                          controller: _emailController,
                          style: TextStyle(color: Colors.white),
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
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 300,
                        child: ElevatedButton(
                          onPressed: () async {
                            if(_emailController.text == ""){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Vui lòng nhập email")));
                            }
                            else if(_passwordController.text == ""){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Vui lòng nhập mật khẩu")));
                            }
                            else{
                              User? user = await _auth.loginUserWithEmailAndPassword(_emailController.text, _passwordController.text);
                              if(user != null){
                                String id_Acount = _emailController.text;
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Đăng nhập thành công")));
                                Navigator.pushReplacement(
                                    context, MaterialPageRoute(
                                  builder: (context) => MainHomePage(),));
                                _emailController.clear();
                                _passwordController.clear();

                              }
                              else{
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Đăng nhập không thành công")));
                              }
                            }
                          },
                          child: Text(
                            'Đăng nhập',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 30),
                            child: TextButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                              ),
                              child: Text(
                                'Quên mật khẩu?',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white70,
                                    decorationColor: Colors.white70),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // lien ket
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              height: 1,
                              color: Colors.white60,
                            ),
                          ),
                          Container(
                            child: Text(
                              'hoặc đăng nhập bằng',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, color: Colors.white60),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              height: 1,
                              color: Colors.white60,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Column(
                        children: [
                          Container(
                            width: 300,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage('assets/images/icon/google.png'),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '  Đăng nhập bằng Google',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            width: 300,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage('assets/images/icon/facebook.png'),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '  Đăng nhập bằng Facebook',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Text('Bạn đã có tài khoản?', style: TextStyle(color: Colors.white70),),
                          ),
                          Container(
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => SignUp()));
                              },
                              child: Text(
                                'Đăng ký',
                                style: TextStyle(
                                    color: Colors.amberAccent, fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        }
    );
  }
}