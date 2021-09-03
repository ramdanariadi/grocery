import 'package:flutter/material.dart';
import 'package:grocery/constrant.dart';
import 'package:grocery/home/WideProductCard.dart';

class RecomendationProducts extends StatelessWidget {
  const RecomendationProducts({
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
            WideProductCard(
              merk: "Avocado",
              imageUrl: "images/avocado.png",
              weight: 100,
              price: 4,
              press: () {},
            ),
            WideProductCard(
              merk: "Orange",
              imageUrl: "images/orange.png",
              weight: 100,
              price: 10,
              press: () {},
            ),
            WideProductCard(
              merk: "Radish",
              imageUrl: "images/radish.png",
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
