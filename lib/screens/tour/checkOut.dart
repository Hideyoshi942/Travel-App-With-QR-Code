import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ptktpm_final_project/screens/home/mainhomepage.dart';
import 'package:ptktpm_final_project/screens/tour/cartView.dart';
import 'package:ptktpm_final_project/screens/tour/detailView.dart';
import 'package:ptktpm_final_project/screens/tour/showTour.dart';
import 'package:ptktpm_final_project/services/dataprocessign.dart';

class CheckOut extends StatefulWidget {
  final String name;
  final String address;
  final String image;
  final double price;
  final double quentity;
  final String email;

  const CheckOut({
    Key? key,
    required this.name,
    required this.image,
    required this.address,
    required this.price,
    required this.quentity,
    required this.email,
  }) : super(key: key);

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  FireStoreService _service = FireStoreService();
  Widget _buildSingleCartProduct() {
    return Column(
      children: [
        Container(
          height: 150,
          width: double.infinity,
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 130,
                      width: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.image),
                        ),
                      ),
                    ),
                    Container(
                      height: 140,
                      width: 180,
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 20),
                            ),
                            Text(
                              widget.address,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                            Text(
                              "Giá: VND " + widget.price.toString(),
                              style: TextStyle(
                                  color: Colors.orangeAccent,
                                  fontWeight: FontWeight.w500),
                            ),
                            Container(
                              height: 35,
                              width: 100,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Vé: "),
                                  Text(widget.quentity.toString()),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomDetail({String? startName, String? endName}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          startName!,
          style: TextStyle(
              fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold),
        ),
        Text(
          endName!,
          style: TextStyle(
            fontSize: 16,
            color: Colors.orangeAccent,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 70,
        width: 100,
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.only(bottom: 10),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          ),
          child: Text(
            "Thanh toán",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Thanh toán"),
                  content: Text("Thanh toán thành công!"),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        QuerySnapshot? queryUser = await _service.getData("User", "email", widget.email);
                        String idTour = "";
                        QuerySnapshot queryFeatureproduct = await FirebaseFirestore.instance.collection("Tour").
                        doc("EtY6L9CkRc3j7j8zn7C1").collection("featureproduct").get();

                        queryFeatureproduct.docs.forEach((element){
                          if(element["address"] == widget.address){
                            idTour = element.id;
                            _service.updateData("User", queryUser!.docs.first.id,
                                {"idTour" : idTour});
                            Navigator.pushReplacement(
                                context, MaterialPageRoute(builder: (context) => MainHomePage(widget.email),));
                            String address, image, name;
                            double price;
                            address = element["address"];
                            image = element["image"];
                            name = element["name"];
                            price = element["price"];
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ShowTour(address, image, name, price),));

                            return;
                          }
                        });

                        QuerySnapshot queryNewachives = await FirebaseFirestore.instance.collection("Tour").
                        doc("EtY6L9CkRc3j7j8zn7C1").collection("newachives").get();

                        queryNewachives.docs.forEach((element){
                          if(element["address"] == widget.address){
                            idTour = element.id;
                            _service.updateData("User", queryUser!.docs.first.id,
                                {"idTour" : idTour});
                            Navigator.pushReplacement(
                                context, MaterialPageRoute(builder: (context) => MainHomePage(widget.email),));
                            String address, image, name;
                            double price;
                            address = queryUser.docs.first["address"];
                            image = queryUser.docs.first["image"];
                            name = queryUser.docs.first["name"];
                            price = queryUser.docs.first["price"];
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ShowTour(address, image, name, price),));
                            return;
                          }
                        });

                        QuerySnapshot queryVietNam = await FirebaseFirestore.instance.collection("Tour").
                        doc("EtY6L9CkRc3j7j8zn7C1").collection("vietnam").get();

                        queryVietNam.docs.forEach((element){
                          if(element["address"] == widget.address){
                            idTour = element.id;
                            _service.updateData("User", queryUser!.docs.first.id,
                                {"idTour" : idTour});
                            Navigator.pushReplacement(
                                context, MaterialPageRoute(builder: (context) => MainHomePage(widget.email),));
                            String address, image, name;
                            double price;
                            address = queryUser.docs.first["address"];
                            image = queryUser.docs.first["image"];
                            name = queryUser.docs.first["name"];
                            price = queryUser.docs.first["price"];
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ShowTour(address, image, name, price),));
                            return;
                          }
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.blue), // Đổi màu nền thành màu xanh
                      ),
                      child: Text(
                        "OK",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartScreen(
                  name: widget.name,
                  address: widget.address,
                  image: widget.image,
                  price: widget.price,
                  quentity: widget.quentity,
                  email: widget.email,
                ),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_none,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                _buildSingleCartProduct(),
                Container(
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildBottomDetail(
                        startName: "Your price",
                        endName: "\$" + widget.price.toString(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
