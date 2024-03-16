import 'package:flutter/material.dart';

class NewsFeed extends StatefulWidget {
  const NewsFeed({Key? key}) : super(key: key);

  @override
  State<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  final TextEditingController _textEditingController = TextEditingController();
  List<String> posts = [];

  void _addPost(String post) {
    setState(() {
      posts.add(post);
      _textEditingController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Bảng tin',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _PostComposer(
                controller: _textEditingController,
                onPressed: () {
                  String postContent = _textEditingController.text;
                  if (postContent.isNotEmpty) {
                    _addPost(postContent);
                    print('Đã đăng bài: $postContent');
                  }
                },
              ),
              SizedBox(height: 16),
              Text(
                'Các bài đăng khác:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Column(
                children: posts.map((post) => _PostCard(post: post)).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PostComposer extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onPressed;

  const _PostComposer({
    required this.controller,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Icon(Icons.person),
                  backgroundColor: Colors.grey,
                  radius: 20,
                ),
                SizedBox(width: 8),
                Text(
                  'Tôi',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 8),
            TextField(
              controller: controller,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Bạn đang nghĩ gì?',
                border: InputBorder.none,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.photo),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.people),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.emoji_emotions_outlined),
                  onPressed: () {},
                ),
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)),
                  onPressed: onPressed,
                  child: Text('Đăng', style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  final String post;

  const _PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 100,
            width: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tôi',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(post),
                SizedBox(height: 25,),
                Row(
                  children: [
                    Icon(Icons.thumb_up, color: Colors.blue,),
                    SizedBox(width: 10,),
                    Icon(Icons.comment,),
                    SizedBox(width: 10,),
                    Icon(Icons.share_outlined,),
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