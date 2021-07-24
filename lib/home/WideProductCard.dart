import 'package:flutter/material.dart';
import 'package:grocery/constrant.dart';

class WideProductCard extends StatelessWidget {
  const WideProductCard({
    Key? key,
    required this.productImageUrl,
    required this.productPrice,
    required this.productWeight,
    required this.productName,
    required this.callback,
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
      height: size.height / 10,
      width: size.width * 0.6,
      padding: EdgeInsets.all(kDefaultPadding / 2),
      margin: EdgeInsets.only(
          top: kDefaultPadding / 2,
          left: kDefaultPadding,
          bottom: kDefaultPadding / 2),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 8),
                blurRadius: 10,
                color: kShadownColor.withOpacity(0.23),
                spreadRadius: 0)
          ],
          borderRadius: BorderRadius.all(Radius.circular(kDefaultPadding / 2))),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Center(child: Image.asset(this.productImageUrl)),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            this.productName,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: "weight ${this.productWeight}",
                  style: TextStyle(color: kTextColor, height: 1.3)),
              TextSpan(
                  text: "g",
                  style: TextStyle(
                      color: kTextColor,
                      fontWeight: FontWeight.bold,
                      height: 1.3))
            ]),
          ),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: "\$${this.productPrice}/",
                style: TextStyle(
                    color: kTextColor,
                    fontWeight: FontWeight.bold,
                    height: 1.3)),
            TextSpan(
                text: "/kg", style: TextStyle(color: kTextColor, height: 1.3))
          ]))
        ]),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              color: Colors.red,
              child: Image.asset(
                "images/icons/plus_icon.png",
                height: 28,
                width: 28,
              ),
            ),
          ],
        )
      ]),
    );
  }
}
