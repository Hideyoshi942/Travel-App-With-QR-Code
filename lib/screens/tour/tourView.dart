import 'package:flutter/material.dart';
class TourView extends StatelessWidget {
  final String image;
  final String address;
  final String name;
  final double price;

  TourView({ required this.image, required this.address, required this.name, required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Container(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
              ),
              height: 250,
              width: 160,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 160,
                    width: 140,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image:
                            NetworkImage(image))),
                  ),
                  SizedBox(height: 10,),
                  Text(name, style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                  Text(address, style: TextStyle(fontWeight: FontWeight.w400),),
                  Text("VND " + price.toString(), style: TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.w500),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
