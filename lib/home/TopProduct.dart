import 'package:flutter/material.dart';
import 'package:grocery/home/ProductCard.dart';

class TopProducts extends StatelessWidget {
  const TopProducts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ProductCard(
            productName: "Broccoli",
            productImageUrl: "images/brokoli.png",
            productPrice: 4,
            productWeight: 100,
            callback: () {},
          ),
          ProductCard(
            productName: "Banana",
            productImageUrl: "images/banana.png",
            productPrice: 10,
            productWeight: 100,
            callback: () {},
          ),
          ProductCard(
            productName: "Radish",
            productImageUrl: "images/radish.png",
            productPrice: 8,
            productWeight: 80,
            callback: () {},
          ),
        ],
      ),
    );
  }
}
