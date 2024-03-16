import 'package:flutter/material.dart';

class CartSingleProduct extends StatefulWidget {
  final String name;
  final String image;
  final String address;
  final double price;
  double quentity; // Thêm từ khóa "late" để không cần khởi tạo giá trị ban đầu

  CartSingleProduct({
    Key? key,
    required this.name,
    required this.image,
    required this.address,
    required this.price,
    required this.quentity,
  }) : super(key: key);

  @override
  State<CartSingleProduct> createState() => _CartSingleProductState();
}

class _CartSingleProductState extends State<CartSingleProduct> {
  int count = 1;

  void incrementCount() {
    setState(() {
      count++;
      widget.quentity = count.toDouble();
    });
  }

  void decrementCount() {
    if (count > 1) {
      setState(() {
        count--;
        widget.quentity = count.toDouble();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      width: 200,
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name,
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                            Text(
                              widget.address,
                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                            Text(
                              "Giá: VND " + widget.price.toString(),
                              style: TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.w500),
                            ),
                            Container(
                              height: 35,
                              width: 120,
                              color: Colors.white70,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: decrementCount,
                                    child: Icon(Icons.remove),
                                  ),
                                  Text(count.toString()),
                                  GestureDetector(
                                    onTap: incrementCount,
                                    child: Icon(Icons.add),
                                  ),
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
}
