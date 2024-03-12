import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService{
  FirebaseFirestore _store = FirebaseFirestore.instance;

  Future<DocumentReference?> addData (Map<String, dynamic> data,  String _nameCollection) async{
    try{
      DocumentReference documentref = await _store.collection(_nameCollection).add(data);
      return documentref;
    }
    catch(err){
      print("có lỗi thêm dữ liệu: $err");
    }
  }
}