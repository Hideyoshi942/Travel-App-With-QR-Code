import 'package:flutter/material.dart';

class Favorite extends StatelessWidget {
  const Favorite({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: favoritePosts.length,
        itemBuilder: (context, index) {
          return _buildPostItem(context, favoritePosts[index]);
        },
      ),
    );
  }

  Widget _buildPostItem(BuildContext context, Post post) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hiển thị hình ảnh
          Image.network(
            post.imageUrl,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hiển thị nội dung bài viết
                Text(
                  post.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(post.description),
                SizedBox(height: 8.0),
                // Hiển thị số lượt thích, bình luận và chia sẻ
                Row(
                  children: [
                    Icon(Icons.favorite, color: Colors.red,),
                    SizedBox(width: 4.0),
                    Text(post.likes.toString()),
                    SizedBox(width: 16.0),
                    Icon(Icons.comment),
                    SizedBox(width: 4.0),
                    Text(post.comments.toString()),
                    SizedBox(width: 16.0),
                    Icon(Icons.share),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Mô hình dữ liệu bài viết
class Post {
  final String imageUrl;
  final String title;
  final String description;
  final int likes;
  final int comments;

  Post({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.likes,
    required this.comments,
  });
}

// Danh sách bài viết giả định
List<Post> favoritePosts = [
  Post(
    imageUrl:
        'https://cdn.tuoitre.vn/thumb_w/480/471584752817336320/2023/11/28/nui-lua-iceland-1701163582283759985432.png',
    title: 'Chuyến đi đến núi lửa',
    description: 'Một chuyến phiêu lưu tuyệt vời tại núi lửa.',
    likes: 20,
    comments: 5,
  ),
  Post(
    imageUrl:
        'https://image.bnews.vn/MediaUpload/Org/2022/07/26/144750-di-tich-quoc-gia-dac-biet-thanh-co-quang-tri-.jpg',
    title: 'Khám phá thành phố cổ',
    description: 'Những khoảnh khắc tuyệt vời tại thành phố cổ.',
    likes: 15,
    comments: 3,
  ),
  Post(
    imageUrl: 'https://cafefcdn.com/203337114487263232/2022/6/12/1-16550161248491665590872.jpg',
    title: 'Dạo chơi trên bãi biển',
    description: 'Những cảnh đẹp bên bờ biển.',
    likes: 30,
    comments: 10,
  ),
];
