import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ptktpm_final_project/screens/tour/detailView.dart';
import 'package:ptktpm_final_project/screens/tour/listTour.dart';
import 'package:ptktpm_final_project/screens/tour/tourView.dart';
import 'package:ptktpm_final_project/screens/user/chat.dart';
import 'package:ptktpm_final_project/screens/user/information.dart';
import 'package:ptktpm_final_project/screens/user/notify.dart';
import 'package:ptktpm_final_project/services/dataprocessign.dart';
import '../tour/tourModel.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // features
  late TourProduct phuquoc;
  late TourProduct sapa;
  late TourProduct bana;
  var featuresSnapshot;

  // newachives
  late TourProduct london;
  late TourProduct maria;
  late TourProduct lama;
  var newAchivesSnapShot;

  Widget _buildCategoryTour(String? image, String? name) {
    return Column(
      children: [
        CircleAvatar(
          maxRadius: 25,
          backgroundImage: AssetImage("assets/images/icon/tien_ich/$image"),
        ),
        Container(
          child: Text(
            name!,
            style: TextStyle(fontSize: 10),
          ),
        ),
      ],
    );
  }

  Widget _buildNewTour(
      {String? name, String? address, String? image, double? price}) {
    return Card(
      child: Column(
        children: [
          Container(
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
                          fit: BoxFit.cover, image: NetworkImage(image!))),
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

  Widget _buildImageSlider() {
    return Container(
      height: 200,
      child: AnotherCarousel(
        autoplay: true,
        showIndicator: false,
        images: [
          AssetImage("assets/images/tour/tour_1/ads1.jpg"),
          AssetImage("assets/images/tour/tour_1/ads2.jpg"),
          AssetImage("assets/images/tour/tour_1/ads3.jpg"),
          AssetImage("assets/images/tour/tour_1/ads4.jpg"),
          AssetImage("assets/images/tour/tour_1/ads5.jpg"),
        ],
      ),
    );
  }

  Widget _buildCategory() {
    return Column(
      children: [
        Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Tiện ích",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Colors.blue,
              ),
            ],
          ),
        ),
        Container(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCategoryTour("airplane-mode.png", "Tìm chuyến bay"),
              _buildCategoryTour("hotel_mode.png", "Tìm khách sạn"),
              _buildCategoryTour("xperience.png", "Xperience"),
              _buildCategoryTour("bus.png", "Vé xe khách"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeatures() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // Căn trái các thành phần con
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Được yêu thích',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => ListTour(
                      name: "Được yêu thích",
                      snapShot: featuresSnapshot,
                    ),
                  ),
                );
              },
              child: Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        SizedBox(height: 10), // Tạo khoảng cách giữa các hàng
        SingleChildScrollView(
          // Sử dụng SingleChildScrollView để cuộn ngang
          scrollDirection: Axis.horizontal, // Chiều cuộn là ngang
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(
                        image: phuquoc.image,
                        name: phuquoc.address,
                        address: phuquoc.name,
                        price: phuquoc.price,
                      ),
                    ),
                  );
                },
                child: TourView(
                  image: phuquoc.image,
                  address: phuquoc.address,
                  name: phuquoc.name,
                  price: phuquoc.price,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(
                        image: sapa.image,
                        name: sapa.address,
                        address: sapa.name,
                        price: sapa.price,
                      ),
                    ),
                  );
                },
                child: TourView(
                  image: sapa.image,
                  address: sapa.address,
                  name: sapa.name,
                  price: sapa.price,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(
                        image: bana.image,
                        name: bana.address,
                        address: bana.name,
                        price: bana.price,
                      ),
                    ),
                  );
                },
                child: TourView(
                  image: bana.image,
                  address: bana.address,
                  name: bana.name,
                  price: bana.price,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTour() {
    return Column(
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
                    'New Tour',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Colors.blue,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNewTour(
                image: london.image,
                address: london.address,
                name: london.name,
                price: london.price,
              ),
              _buildNewTour(
                image: maria.image,
                address: maria.address,
                name: maria.name,
                price: maria.price,
              ),
              _buildNewTour(
                image: lama.image,
                address: lama.address,
                name: lama.name,
                price: lama.price,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.blue,
        flexibleSpace: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          margin: EdgeInsets.only(top: 30),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Icon(Icons.search, color: Colors.grey),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextFormField(
                            style: TextStyle(color: Colors.grey),
                            onTap: () {},
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 10),
                              hintText: "Tìm kiếm...",
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Notify(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Chat(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.message,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("Tour")
            .doc("EtY6L9CkRc3j7j8zn7C1")
            .collection("featureproduct")
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          featuresSnapshot = snapshot;
          phuquoc = TourProduct(
              name: snapshot.data!.docs[0]["name"],
              image: snapshot.data!.docs[0]["image"],
              address: snapshot.data!.docs[0]["address"],
              price: snapshot.data!.docs[0]["price"]);
          sapa = TourProduct(
              name: snapshot.data!.docs[1]["name"],
              image: snapshot.data!.docs[1]["image"],
              address: snapshot.data!.docs[1]["address"],
              price: snapshot.data!.docs[1]["price"]);
          bana = TourProduct(
              name: snapshot.data!.docs[2]["name"],
              image: snapshot.data!.docs[2]["image"],
              address: snapshot.data!.docs[2]["address"],
              price: snapshot.data!.docs[2]["price"]);
          return FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection("Tour")
                  .doc("EtY6L9CkRc3j7j8zn7C1")
                  .collection("newachives")
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                london = TourProduct(
                    name: snapshot.data!.docs[0]["name"],
                    image: snapshot.data!.docs[0]["image"],
                    address: snapshot.data!.docs[0]["address"],
                    price: snapshot.data!.docs[0]["price"]);
                maria = TourProduct(
                    name: snapshot.data!.docs[1]["name"],
                    image: snapshot.data!.docs[1]["image"],
                    address: snapshot.data!.docs[1]["address"],
                    price: snapshot.data!.docs[1]["price"]);
                lama = TourProduct(
                    name: snapshot.data!.docs[2]["name"],
                    image: snapshot.data!.docs[2]["image"],
                    address: snapshot.data!.docs[2]["address"],
                    price: snapshot.data!.docs[2]["price"]);
                newAchivesSnapShot = snapshot;
                return Container(
                  height: double.infinity,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    _buildImageSlider(),
                                    // category
                                    _buildCategory(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // features
                          _buildFeatures(),
                          // new tour
                          _buildTour(),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
