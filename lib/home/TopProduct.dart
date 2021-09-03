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
            merk: "Broccoli",
            imageUrl: "images/brokoli.png",
            press: (){},
            price: 4,
            weight: 100,
          ),
          ProductCard(
            merk: "Banana",
            imageUrl: "images/banana.png",
            press: (){},
            price: 10,
            weight: 100,
          ),
          ProductCard(
            merk: "Radish",
            imageUrl: "images/radish.png",
            press: (){},
            price: 8,
            weight: 80,
          ),
        ],
      ),
    );
  }
}
