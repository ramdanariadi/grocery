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
            productName: "Avocado",
            productImageUrl: "images/avocado.png",
            productPrice: 9,
            productWeight: 220,
            callback: () {},
          ),
          WideProductCard(
            productName: "Orange",
            productImageUrl: "images/orange.png",
            productPrice: 4,
            productWeight: 160,
            callback: () {},
          ),
        ],
      ),
    );
  }
}
