import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseAuthService{
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> registerUserWithEmailAndPassword(String strEmail, String strPassword) async{
    try{
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: strEmail, password: strPassword);
      return credential.user;
    }
    catch(err){
      print("Có lỗi đăng ký: $err");
    }
  }
  Future<User?> loginUserWithEmailAndPassword(String strEmail, String strPassword) async{
    try{
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: strEmail, password: strPassword);
      return credential.user;
    }
    catch(err){
      print("có lỗi đăng nhập: $err");
    }
  }

  Future<void> SignOut() async{
    try{
      await _auth.signOut();
    }
    catch(err){
      print("Có đăng xuất: $err");
    }
  }
}