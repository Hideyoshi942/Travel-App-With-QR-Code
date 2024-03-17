import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ptktpm_final_project/screens/user/information.dart';
import 'package:ptktpm_final_project/services/dataprocessign.dart';
import 'package:intl/intl.dart';

class Profile extends StatefulWidget {
  String email;

  Profile(this.email);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FireStoreService _service = FireStoreService();

  late TextEditingController _fullNameController;
  late TextEditingController _dateOfBirthController;
  late TextEditingController _genderController;
  late TextEditingController _hometownController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _dateOfBirthController = TextEditingController();
    _genderController = TextEditingController();
    _hometownController = TextEditingController();
    _emailController = TextEditingController();
    _phoneNumberController = TextEditingController();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _dateOfBirthController.dispose();
    _genderController.dispose();
    _hometownController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Thông tin cá nhân',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _fullNameController,
              decoration: InputDecoration(labelText: 'Họ và tên'),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _dateOfBirthController,
              decoration: InputDecoration(labelText: 'Ngày sinh'),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _genderController,
              decoration: InputDecoration(labelText: 'Giới tính'),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _hometownController,
              decoration: InputDecoration(labelText: 'Quê quán'),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _phoneNumberController,
              decoration: InputDecoration(labelText: 'Số điện thoại'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    onPressed: () async {
                      QuerySnapshot? query =
                          await _service.getData("User", "email", widget.email);
                      if (query != null) {
                        DocumentSnapshot document = query.docs.first;
                        _emailController.text = document["email"];
                        _fullNameController.text = document["name"];
                        _dateOfBirthController.text = document["date"];
                        _phoneNumberController.text = document["phone_Number"];
                        _genderController.text = document["gender"];
                        _hometownController.text = document["address"];
                      }
                    },
                    child: Text(
                      "Xem",
                      style: TextStyle(fontSize: 20),
                    )),
                SizedBox(
                  width: 50,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Xác nhận Sửa đổi thông tin cá nhân"),
                            content: Text('Bạn có chắc chắn muốn tiếp tục?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('No'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  QuerySnapshot? query = await _service.getData(
                                      "User", 'email', widget.email);
                                  DocumentSnapshot? document =
                                      query?.docs.first;
                                  if (query != null && query.docs.isNotEmpty) {
                                    // Kiểm tra xem danh sách có phần tử không
                                    DocumentSnapshot document =
                                        query.docs.first;
                                    _emailController.text = document["email"];
                                    _fullNameController.text = document["name"];
                                    _dateOfBirthController.text =
                                        document["date"];
                                    _phoneNumberController.text =
                                        document["phone_Number"];
                                    _genderController.text = document["gender"];
                                    _hometownController.text =
                                        document["address"];
                                  } else {
                                    Map<String, dynamic> newdata = {
                                      'name': _fullNameController.text,
                                      'date': DateFormat('yyyy/MM/dd')
                                          .format(DateTime.now()),
                                      'gender': _genderController.text,
                                      'address': _hometownController.text,
                                      'email': widget.email,
                                      'phone_Number':
                                          _phoneNumberController.text,
                                    };

                                    _service.updateData(
                                        "User", document!.id, newdata);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "thông tin cá nhân đã được cập nhật")));
                                    Navigator.of(context).pop();
                                    print('chon sua doi thong tin');
                                  }
                                },
                                child: Text('Yes'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      "Sửa",
                      style: TextStyle(fontSize: 20),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
