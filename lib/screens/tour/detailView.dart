import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ptktpm_final_project/screens/home/mainhomepage.dart';
import 'package:ptktpm_final_project/screens/home/myhomepage.dart';
import 'package:ptktpm_final_project/screens/tour/cartView.dart';

class DetailScreen extends StatefulWidget {
  final String email;
  final String image;
  final String name;
  final String address;
  final double price;

  const DetailScreen(
      {super.key,
      required this.image,
      required this.name,
      required this.address,
      required this.price,
      required this.email});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int count = 1;

  @override
  Widget _buildSizeProduct({String? name}) {
    return Container(
      height: 50,
      width: 50,
      color: Colors.blue,
      child: Center(
        child: Text(name!),
      ),
    );
  }

  Widget _buildColorProduct({Color? color}) {
    return Container(
      height: 50,
      width: 50,
      color: color,
    );
  }

  Widget _buildImage() {
    return Center(
      child: Container(
        width: 350,
        child: Card(
          child: Container(
            padding: EdgeInsets.all(13),
            child: Container(
              height: 220,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.image),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameToDescriptionPart() {
    return Container(
      height: 80,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.name, style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
              Text(widget.address, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
              Text("Giá: VND " + widget.price.toString(), style: TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.w500),),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDiscription() {
    return Container(
      height: 300,
      child: Wrap(
        children: [
          Text("Thông tin chuyến đi", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
        ],
      ),
    );
  }

  Widget _buildSizePart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Size"),
        SizedBox(
          height: 10,
        ),
        Container(
          width: 265,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSizeProduct(name: "S"),
              _buildSizeProduct(name: "M"),
              _buildSizeProduct(name: "L"),
              _buildSizeProduct(name: "Xl"),
              _buildSizeProduct(name: "XXl"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildColorPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Text("Size"),
        SizedBox(
          height: 10,
        ),
        Container(
          width: 265,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildColorProduct(color: Colors.black),
              _buildColorProduct(color: Colors.blue),
              _buildColorProduct(color: Colors.green),
              _buildColorProduct(color: Colors.orange),
              _buildColorProduct(color: Colors.yellow),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuantity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Text("Vé"),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 30,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.cyan,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(count.toString()),
            ],
          ),
        ),
      ],
    );
  }
  Widget _buildCheckOut() {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        Container(
          height: 60,
          width: double.infinity,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(
                    name: widget.name,
                    address: widget.address,
                    image: widget.image,
                    price: widget.price,
                    quentity: count.toDouble(),
                    email: widget.email,
                  ),
                ),
              );
            },
            child: Text('Mua', style: TextStyle(color: Colors.white),),
          ),
        ),
      ],
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainHomePage(widget.email)),
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
      body: Container(
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildImage(),
                      SizedBox(
                        height: 10,
                      ),
                      _buildNameToDescriptionPart(),
                      _buildDiscription(),
                      // _buildSizePart(),
                      // _buildColorPart(),
                      _buildQuantity(),
                      SizedBox(
                        height: 10,
                      ),
                      _buildCheckOut(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
