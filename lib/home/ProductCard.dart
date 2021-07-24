import 'package:flutter/material.dart';

import '../constrant.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.productImageUrl,
    required this.productPrice,
    required this.productWeight,
    required this.callback,
    required this.productName,
  }) : super(key: key);

  final String productImageUrl;
  final int productPrice;
  final int productWeight;
  final String productName;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width * 0.4,
        margin: EdgeInsets.only(
            left: kDefaultPadding,
            top: kDefaultPadding / 2,
            bottom: kDefaultPadding / 2),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 8),
                  blurRadius: 10,
                  spreadRadius: 0,
                  color: kShadownColor.withOpacity(0.23))
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(kDefaultPadding / 2),
                topRight: Radius.circular(kDefaultPadding / 2),
                bottomLeft: Radius.circular(kDefaultPadding / 2),
                bottomRight: Radius.circular(kDefaultPadding / 2))),
        child: Column(
          children: [
            Image.asset(this.productImageUrl),
            Container(
              padding: EdgeInsets.all(kDefaultPadding / 1.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        this.productName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: "weight ",
                            style: TextStyle(color: Colors.black, height: 1.3)),
                        TextSpan(
                            text: "${productWeight}g",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                height: 1.3))
                      ])),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: "\$${this.productPrice} ",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                height: 1.3)),
                        TextSpan(
                            text: "/kg",
                            style: TextStyle(color: Colors.black, height: 1.3))
                      ])),
                    ],
                  ),
                  GestureDetector(
                      onTap: callback,
                      child: Image.asset("images/icons/plus_icon.png"))
                ],
              ),
            )
          ],
        ));
  }
}
