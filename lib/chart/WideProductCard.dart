import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery/constrant.dart';

import 'package:grocery/product/ProductCard.dart';
import 'package:grocery/product/ProductDetail.dart';

class WideProductCard extends StatefulWidget {
  WideProductCard({
    Key? key,
    required this.merk,
    required this.category,
    required this.weight,
    required this.price,
    required this.total,
    required this.imageUrl,
  }) : super(key: key);

  final String merk;
  final int weight;
  final int price;
  final String category;
  final String imageUrl;
  int total;

  factory WideProductCard.fromJson(Map<String, dynamic> item) {
    return new WideProductCard(
        merk: item['name'],
        weight: item['weight'],
        price: item['price'],
        total: item['total'],
        category: item['category'],
        imageUrl: item['imageUrl']);
  }

  @override
  State<StatefulWidget> createState() {
    return _WideProductCard();
  }
}

class _WideProductCard extends State<WideProductCard> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void handleCountChange(context) {
    setState(() {
      if (context == 'plus') widget.total++;
      if (context == 'minus') widget.total--;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double cardHeight = size.height / 6.5;
    return Container(
      width: size.width,
      height: cardHeight,
      margin: EdgeInsets.only(top: kDefaultPadding / 2),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProductDetail.routeName,
                      arguments: ProductArguments(
                          widget.merk, widget.category, widget.weight, widget.price, widget.imageUrl));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.imageUrl == 'null' || widget.imageUrl == 'notFound.png'
                        ? Image.asset(
                            'images/notFound.png',
                            height: cardHeight * 0.6,
                            width: size.width / 5,
                          )
                        : Image.network(
                            widget.imageUrl,
                            height: cardHeight * 0.6,
                            width: size.width / 5,
                          ),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "\$${widget.price}",
                          style: TextStyle(
                              height: 1.5,
                              color: kBlackHint,
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: "/kg",
                          style: TextStyle(height: 1.5, color: kBlackHint)),
                    ])),
                  ],
                ),
              ),
              Container(
                height: cardHeight - (kDefaultPadding),
                padding: EdgeInsets.all(kDefaultPadding / 2),
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "${widget.merk}\n",
                      style: TextStyle(
                          height: 1.5,
                          color: kBlackHint,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: "weight ",
                      style: TextStyle(height: 1.5, color: kBlackHint)),
                  TextSpan(
                      text: "${widget.weight}g\n",
                      style: TextStyle(
                          height: 1.5,
                          color: kBlackHint,
                          fontWeight: FontWeight.w500)),
                ])),
              ),
            ],
          ),
          Container(
            height: size.height / 6,
            padding: EdgeInsets.only(
                top: kDefaultPadding / 2,
                right: kDefaultPadding * 1.2,
                bottom: kDefaultPadding / 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // SvgPicture.asset('images/icons/trashbin.svg'),
                Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          handleCountChange('minus');
                        },
                        child: Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                                color: Colors.white38,
                                borderRadius: BorderRadius.circular(2)),
                            child: SvgPicture.asset('images/icons/minus.svg'))),
                    SizedBox(
                      width: 13,
                    ),
                    Text(
                      "${widget.total}",
                      style: TextStyle(
                          fontSize: 18,
                          color: kBlackHint,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 13,
                    ),
                    GestureDetector(
                        onTap: () {
                          handleCountChange('plus');
                        },
                        child: Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                                color: Colors.white38,
                                borderRadius: BorderRadius.circular(2)),
                            child: SvgPicture.asset('images/icons/plus.svg'))),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
