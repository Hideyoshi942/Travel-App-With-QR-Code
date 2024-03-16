import 'package:flutter/material.dart';

class CartModel {
  final String name;
  final String address;
  final String image;
  final double price;
  final double quentity;

  CartModel(
      {required this.name,
      required this.address,
      required this.image,
      required this.price,
      required this.quentity});
}
