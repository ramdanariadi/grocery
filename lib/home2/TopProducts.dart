import 'package:flutter/material.dart';
import 'package:grocery/constrant.dart';
import 'package:grocery/home2/ProductCard.dart';

class TopProducts extends StatelessWidget {
  const TopProducts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ProductCard(
              merk: "Broccoli",
              imageUrl: "images/brokoli.png",
              weight: 100,
              price: 4,
              press: () {},
            ),
            ProductCard(
              merk: "Banana",
              imageUrl: "images/banana.png",
              weight: 100,
              price: 10,
              press: () {},
            ),
            ProductCard(
              merk: "Carrot",
              imageUrl: "images/carrot.png",
              weight: 120,
              price: 4,
              press: () {},
            ),
          ],
        ),
      ),
    );
  }
}
