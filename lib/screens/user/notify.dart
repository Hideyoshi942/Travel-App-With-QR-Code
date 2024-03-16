import 'package:flutter/material.dart';

class Notify extends StatelessWidget {
  const Notify({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông báo', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Card(
        elevation: 4, // Độ nổi của card
        margin: EdgeInsets.all(8), // Khoảng cách từ card đến các phần tử khác
        child: ListTile(
          contentPadding: EdgeInsets.all(8), // Khoảng cách từ nội dung đến các biên của ListTile
          leading: CircleAvatar(
            radius: 20, // Bán kính của avatar
            backgroundImage: AssetImage('assets/images/tour/tour_1/thap.jpg'), // Hình ảnh của avatar
          ),
          title: Text(
            'Bot App', // Tiêu đề của thông báo
            style: TextStyle(
              fontWeight: FontWeight.bold, // Font chữ in đậm
            ),
          ),
          subtitle: Text(
            'Chào mừng bạn đến với app', // Nội dung của thông báo
          ),
        ),
      ),
    );
  }
}
