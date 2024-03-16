import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ptktpm_final_project/screens/home/mainhomepage.dart';
import 'package:ptktpm_final_project/screens/home/myhomepage.dart';
import 'package:ptktpm_final_project/screens/tour/cartSingleProduct.dart';
import 'package:ptktpm_final_project/screens/tour/checkOut.dart';

class CartScreen extends StatefulWidget {
  final String name;
  final String address;
  final String image;
  final double price;
  final double quentity;

  const CartScreen({
    super.key,
    required this.name,
    required this.address,
    required this.image,
    required this.price,
    required this.quentity,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

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
          child: Text("Thanh Toán", style: TextStyle(color: Colors.white),),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CheckOut(
                      name: widget.name,
                      address: widget.address,
                      image: widget.image,
                      price: widget.price,
                      quentity: widget.quentity,
                  ),),
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
              MaterialPageRoute(builder: (context) => MainHomePage()),
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
      body: Column(
        children: [
          CartSingleProduct(
              name: widget.name,
              image: widget.image,
              address: widget.address,
              price: widget.price,
              quentity: widget.quentity
          ),
        ],
      ),
    );
  }
}
