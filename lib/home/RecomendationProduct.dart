import 'package:flutter/material.dart';
import 'package:grocery/home/WideProductCard.dart';

class RecomendationProduct extends StatelessWidget {
  const RecomendationProduct({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          WideProductCard(
            merk: "Avocado",
            imageUrl: "images/avocado.png",
            price: 9,
            weight: 220,
            press: () {},
          ),
          WideProductCard(
            merk: "Orange",
            imageUrl: "images/orange.png",
            price: 4,
            weight: 160,
            press: () {},
          ),
        ],
      ),
    );
  }
}
