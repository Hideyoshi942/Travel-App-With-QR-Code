import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<String> messages = [
    'Xin chào!',
    'Chào bạn!',
    'Bạn đang làm gì vậy?',
    'Tôi đang xem phim.',
    'Bạn muốn xem cùng không?',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Chat', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          // Định dạng tin nhắn
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: EdgeInsets.all(12.0),
              child: Text(messages[index]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Thêm tin nhắn mới khi nhấn vào nút
          setState(() {
            messages.add('Tin nhắn mới');
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
