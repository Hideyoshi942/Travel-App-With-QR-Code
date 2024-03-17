import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchTourInformation extends StatefulWidget{
  Map<String, dynamic> infor;


  SearchTourInformation(this.infor);

  @override
  State<StatefulWidget> createState() {
    return SearchTourInfotmationState();
  }

}

class SearchTourInfotmationState extends State<SearchTourInformation>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(widget.infor["image"]),
              ),
              color: Colors.white70,
            ),
            Text(widget.infor["name"], style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),),
            Text(widget.infor["address"], style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
            Text(widget.infor["price"].toString(), style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, color: Colors.orange),),
            Text("Thông tin chuyến đi"),
            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
          ],
        ),
      ),
    );
  }

}