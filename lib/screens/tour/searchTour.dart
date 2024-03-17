import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ptktpm_final_project/screens/tour/searchTourInformation.dart';
import 'package:ptktpm_final_project/services/dataprocessign.dart';

import 'listTour.dart';

class SearchTour extends StatefulWidget{
  String address;
  List<Map<String, dynamic>> listTour;
  
  SearchTour(this.address, this.listTour);

  @override
  State<StatefulWidget> createState() {
    return SearchTourState();
  }
}

class SearchTourState extends State<SearchTour>{
  FireStoreService _store = FireStoreService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: widget.listTour.length,
        itemBuilder: (context, index){
          return Column(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Container(
                          child: SearchTourInformation(widget.listTour[index]),
                        ),
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.white70,
                    margin: EdgeInsets.all(8),
                    shadowColor: Colors.black87,
                    elevation: 10,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                          child: Image.network(
                            widget.listTour[index]["image"],

                          ),
                        ),
                        Text(widget.listTour[index]["name"], style: TextStyle(fontSize: 50, fontWeight: FontWeight.w800),),
                        Text(widget.listTour[index]["address"], style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                        Text(widget.listTour[index]["price"].toString(), style: TextStyle(fontSize: 40, fontWeight: FontWeight.w800, color: Colors.orange)),
                      ],
                    ),
                  )
              ),
            ],
          );
        },
      ),
    );
  }
}