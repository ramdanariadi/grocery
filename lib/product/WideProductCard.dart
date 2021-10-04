import 'package:flutter/material.dart';
import 'package:grocery/constrant.dart';

import 'ProductCard.dart';
import 'ProductDetail.dart';

class WideProductCard extends StatelessWidget {
  const WideProductCard({
    Key? key,
    required this.merk,
    required this.category,
    required this.weight,
    required this.price,
    required this.imageUrl,
  }) : super(key: key);

  final String merk;
  final int weight;
  final int price;
  final String category;
  final String imageUrl;

  factory WideProductCard.fromJson(Map<String, dynamic> item) {
    return new WideProductCard(
        merk: item['name'],
        weight: item['weight'],
        price: item['price'],
        category: item['category'],
        imageUrl: item['imageUrl']);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.65,
      margin: EdgeInsets.only(
          left: kDefaultPadding / 2, right: kDefaultPadding / 2),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 8),
                color: kShadownColor.withOpacity(0.23),
                spreadRadius: -10,
                blurRadius: 20)
          ],
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ProductDetail.routeName,
                  arguments: ProductArguments(
                      merk, category, weight, price, imageUrl));
            },
            child: this.imageUrl == 'null' || this.imageUrl == 'notFound.png'
                ? Image.asset(
                    'images/notFound.png',
                    width: size.width / 5,
                  )
                : Image.network(
                    this.imageUrl,
                    width: size.width / 5,
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding / 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "${this.merk}\n",
                      style: TextStyle(
                          height: 1.5,
                          color: kBlackHint,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: "weight ",
                      style: TextStyle(height: 1.5, color: kBlackHint)),
                  TextSpan(
                      text: "${this.weight}g\n",
                      style: TextStyle(
                          height: 1.5,
                          color: kBlackHint,
                          fontWeight: FontWeight.w500)),
                  TextSpan(
                      text: "\$${this.price}",
                      style: TextStyle(
                          height: 1.5,
                          color: kBlackHint,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: "/kg",
                      style: TextStyle(height: 1.5, color: kBlackHint)),
                ])),
                SizedBox(
                  width: kDefaultPadding,
                ),
                GestureDetector(
                    onTap: () {},
                    child: Image.asset("images/icons/plus_icon.png"))
              ],
            ),
          )
        ],
      ),
    );
  }
}
