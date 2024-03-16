import 'package:flutter/material.dart';
import 'package:ptktpm_final_project/screens/home/mainhomepage.dart';
import 'package:ptktpm_final_project/screens/home/myhomepage.dart';
import 'package:ptktpm_final_project/screens/tour/tourModel.dart';
import 'package:ptktpm_final_project/screens/tour/tourView.dart';

class ListTour extends StatelessWidget {
  final String name;
  final String email;
  final snapShot;

  ListTour({required this.name, required this.snapShot , required this.email});

  @override
  Widget TourView({String? name, String? address, String? image, double? price}) {
    return Card(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
            ),
            height: 250,
            width: 160,
            child: Column(
              children: [
                Container(
                  height: 160,
                  width: 140,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                          NetworkImage(image!),),),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  name!,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                Text(
                  address!,
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
                Text(
                  "VND " + price.toString(),
                  style: TextStyle(
                      color: Colors.orangeAccent, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MainHomePage(email)),
              );
            },
            icon: Icon(Icons.arrow_back, color: Colors.white,)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search, color: Colors.white,)),
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications, color: Colors.white,))
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                  height: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  height: 700,
                  child: GridView.builder(
                    itemCount: snapShot.data.docs.length,
                    itemBuilder: (context, index) =>
                        TourView(name: snapShot.data.docs[index]["name"],
                            image: snapShot.data.docs[index]["image"],
                            address: snapShot.data.docs[index]["address"],
                            price: snapShot.data.docs[index]["price"],
                        ),
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.64,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
