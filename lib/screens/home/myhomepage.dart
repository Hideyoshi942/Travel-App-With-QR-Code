import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ptktpm_final_project/screens/tour/detailView.dart';
import 'package:ptktpm_final_project/screens/tour/listTour.dart';
import 'package:ptktpm_final_project/screens/tour/listTourOther.dart';
import 'package:ptktpm_final_project/screens/tour/searchTour.dart';
import 'package:ptktpm_final_project/screens/tour/tourView.dart';
import 'package:ptktpm_final_project/screens/user/chat.dart';
import 'package:ptktpm_final_project/screens/user/information.dart';
import 'package:ptktpm_final_project/screens/user/notify.dart';
import 'package:ptktpm_final_project/services/dataprocessign.dart';
import '../tour/tourModel.dart';

class MyHomePage extends StatefulWidget {
  String email;

  MyHomePage(this.email);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _searchController = TextEditingController();

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

  // hotel
  late TourProduct ht1;
  late TourProduct ht2;
  late TourProduct ht3;
  var hotelSnapShot;

  // play
  late TourProduct play1;
  late TourProduct play2;
  late TourProduct play3;
  var playSnapShot;

  // normal
  late TourProduct normal1;
  late TourProduct normal2;
  late TourProduct normal3;
  late TourProduct normal4;
  var normalSnapShot;

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
                      email: widget.email,
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
                        name: phuquoc.name,
                        address: phuquoc.address,
                        price: phuquoc.price,
                        email: widget.email,
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
                        name: sapa.name,
                        address: sapa.address,
                        price: sapa.price,
                        email: widget.email,
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
                        name: bana.name,
                        address: bana.address,
                        price: bana.price,
                        email: widget.email,
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
                    'Chuyến đi mới',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => ListTour(
                            name: "Chuyến đi mới",
                            email: widget.email,
                            snapShot: newAchivesSnapShot,
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

  Widget _buildTourNormal() {
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
                    'Các chuyến đi khác',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        // ListTourOther(name: "Các chuyến đi khác", snapShot: normalSnapShot, email: widget.email),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  _buildNewTour(
                    image: normal1.image,
                    address: normal1.address,
                    name: normal1.name,
                    price: normal1.price,
                  ),
                  _buildNewTour(
                    image: normal2.image,
                    address: normal2.address,
                    name: normal2.name,
                    price: normal2.price,
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  _buildNewTour(
                    image: normal3.image,
                    address: normal3.address,
                    name: normal3.name,
                    price: normal3.price,
                  ),
                  _buildNewTour(
                    image: normal4.image,
                    address: normal4.address,
                    name: normal4.name,
                    price: normal4.price,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAds1() {
    return Container(
      height: 80,
      width: double.infinity,
      child: Image.network(
        "https://www.wordstream.com/wp-content/uploads/2021/07/persuasive-ads-coca-cola-1.jpg",
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildAds2() {
    return Column(
      children: [
        Container(
          height: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Khuyến mãi',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.arrow_downward,
                    color: Colors.blue,
                    size: 16,
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
              SizedBox(
                height: 60,
                child: Flexible(
                  child: Image.network(
                      "https://bizweb.dktcdn.net/100/403/043/themes/786118/assets/slide-img3.png?1649906484793",
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                height: 60,
                child: Flexible(
                  child: Image.network(
                      "https://bizweb.dktcdn.net/100/403/043/themes/786118/assets/slide-img1.png?1649906484793",
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                height: 60,
                child: Flexible(
                  child: Image.network(
                      "https://viettelmoney.vn/wp-content/uploads/2022/09/voucher-giam-gia.jpg",
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                height: 60,
                child: Flexible(
                  child: Image.network(
                      "https://static.vivnpay.vn/vnpay_landing_old/93688y1652081165239_0.jpeg",
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                height: 60,
                child: Flexible(
                  child: Image.network(
                      "https://cdn.tgdd.vn/Files/2022/01/20/1411900/avakids-2_1280x720-800-resize.png",
                      fit: BoxFit.cover),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHotel() {
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
                    'Khám phá các khách sạn',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => ListTour(
                            name: "Khám phá các khách sạn",
                            email: widget.email,
                            snapShot: hotelSnapShot,
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
                image: ht1.image,
                address: ht1.address,
                name: ht1.name,
                price: ht1.price,
              ),
              _buildNewTour(
                image: ht2.image,
                address: ht2.address,
                name: ht2.name,
                price: ht2.price,
              ),
              _buildNewTour(
                image: ht3.image,
                address: ht3.address,
                name: ht3.name,
                price: ht3.price,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlay() {
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
                    'Các khu vui chơi nổi tiếng',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => ListTour(
                            name: "Các khu vui chơi nổi tiếng",
                            email: widget.email,
                            snapShot: playSnapShot,
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
                image: play1.image,
                address: play1.address,
                name: play1.name,
                price: play1.price,
              ),
              _buildNewTour(
                image: play2.image,
                address: play2.address,
                name: play2.name,
                price: play2.price,
              ),
              _buildNewTour(
                image: play3.image,
                address: play3.address,
                name: play3.name,
                price: play3.price,
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
                        padding: const EdgeInsets.only(left: 0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),),
                            ),
                            onPressed: () async {
                              List<Map<String, dynamic>> list = [];
                              DocumentSnapshot documentsn = await FirebaseFirestore.instance.
                              collection("Tour").doc('EtY6L9CkRc3j7j8zn7C1').get();

                              QuerySnapshot vn = await documentsn.reference.collection("vietnam").get();
                              vn.docs.forEach((e) {
                                String search = e["address"].toLowerCase().trim();
                                if(search == _searchController.text.toLowerCase().trim()){

                                  Map<String, dynamic> m = {};
                                  m['address'] = e['address'];
                                  m['image'] = e['image'];
                                  m['name'] = e['name'];
                                  m['price'] = e['price'];
                                  list.add(m);
                                }
                              });

                              QuerySnapshot na = await documentsn.reference.collection("newachives").get();
                              na.docs.forEach((e) {
                                String search = e["address"].toLowerCase().trim();
                                if(search == _searchController.text.toLowerCase().trim()){

                                  Map<String, dynamic> m = {};
                                  m['address'] = e['address'];
                                  m['image'] = e['image'];
                                  m['name'] = e['name'];
                                  m['price'] = e['price'];
                                  list.add(m);
                                }
                              });

                              QuerySnapshot fp = await documentsn.reference.collection("featureproduct").get();
                              fp.docs.forEach((e) {
                                String search = e["address"].toLowerCase().trim();
                                if(search == _searchController.text.toLowerCase().trim()){
                                  Map<String, dynamic> m = {};
                                  m['address'] = e['address'];
                                  m['image'] = e['image'];
                                  m['name'] = e['name'];
                                  m['price'] = e['price'];
                                  list.add(m);
                                }
                              });
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SearchTour(_searchController.text, list),)) ;
                            },
                            child: Icon(Icons.search, color: Colors.grey)),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextFormField(
                            controller: _searchController,
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
              return FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection("Tour")
                    .doc("EtY6L9CkRc3j7j8zn7C1")
                    .collection("hotel")
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  ht1 = TourProduct(
                      name: snapshot.data!.docs[0]["name"],
                      image: snapshot.data!.docs[0]["image"],
                      address: snapshot.data!.docs[0]["address"],
                      price: snapshot.data!.docs[0]["price"]);
                  ht2 = TourProduct(
                      name: snapshot.data!.docs[1]["name"],
                      image: snapshot.data!.docs[1]["image"],
                      address: snapshot.data!.docs[1]["address"],
                      price: snapshot.data!.docs[1]["price"]);
                  ht3 = TourProduct(
                      name: snapshot.data!.docs[2]["name"],
                      image: snapshot.data!.docs[2]["image"],
                      address: snapshot.data!.docs[2]["address"],
                      price: snapshot.data!.docs[2]["price"]);
                  hotelSnapShot = snapshot;
                  return FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("Tour")
                        .doc("EtY6L9CkRc3j7j8zn7C1")
                        .collection("play")
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      play1 = TourProduct(
                          name: snapshot.data!.docs[0]["name"],
                          image: snapshot.data!.docs[0]["image"],
                          address: snapshot.data!.docs[0]["address"],
                          price: snapshot.data!.docs[0]["price"]);
                      play2 = TourProduct(
                          name: snapshot.data!.docs[1]["name"],
                          image: snapshot.data!.docs[1]["image"],
                          address: snapshot.data!.docs[1]["address"],
                          price: snapshot.data!.docs[1]["price"]);
                      play3 = TourProduct(
                          name: snapshot.data!.docs[2]["name"],
                          image: snapshot.data!.docs[2]["image"],
                          address: snapshot.data!.docs[2]["address"],
                          price: snapshot.data!.docs[2]["price"]);
                      playSnapShot = snapshot;
                      return FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection("Tour")
                            .doc("EtY6L9CkRc3j7j8zn7C1")
                            .collection("vietnam")
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          normal1 = TourProduct(
                              name: snapshot.data!.docs[0]["name"],
                              image: snapshot.data!.docs[0]["image"],
                              address: snapshot.data!.docs[0]["address"],
                              price: snapshot.data!.docs[0]["price"]);
                          normal2 = TourProduct(
                              name: snapshot.data!.docs[1]["name"],
                              image: snapshot.data!.docs[1]["image"],
                              address: snapshot.data!.docs[1]["address"],
                              price: snapshot.data!.docs[1]["price"]);
                          normal3 = TourProduct(
                              name: snapshot.data!.docs[2]["name"],
                              image: snapshot.data!.docs[2]["image"],
                              address: snapshot.data!.docs[2]["address"],
                              price: snapshot.data!.docs[2]["price"]);
                          normal4 = TourProduct(
                              name: snapshot.data!.docs[3]["name"],
                              image: snapshot.data!.docs[3]["image"],
                              address: snapshot.data!.docs[3]["address"],
                              price: snapshot.data!.docs[3]["price"]);
                          normalSnapShot = snapshot;
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
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
                                    // ads1
                                    _buildAds1(),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    // features
                                    _buildFeatures(),
                                    //ads2
                                    _buildAds2(),
                                    // new tour
                                    _buildTour(),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    // hotel
                                    _buildHotel(),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    // khu vui choi
                                    _buildPlay(),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    // tour defferient
                                    _buildTourNormal(),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
