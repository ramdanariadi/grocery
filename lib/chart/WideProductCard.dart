import 'package:flutter/material.dart';
import 'package:grocery/constant.dart';
import 'package:grocery/custom_widget/Button.dart';
import 'package:grocery/product/ProductCard.dart';
import 'package:grocery/product/ProductDetail.dart';

// ignore: must_be_immutable
class WideProductCard extends StatefulWidget {
  WideProductCard({
    Key? key,
    required this.callback,
    required this.id,
    required this.productId,
    required this.merk,
    required this.category,
    required this.weight,
    required this.price,
    required this.total,
    String? imageUrl,
  }) : super(key: key) {
    this.imageUrl = imageUrl;
  }

  final String id;
  final String productId;
  final String merk;
  final int weight;
  final int price;
  final String category;
  String? imageUrl;
  int total;
  final VoidCallback callback;

  factory WideProductCard.fromJson(
      Map<String, dynamic> item, VoidCallback callback) {
    return new WideProductCard(
      id: item['id'],
      productId: item['product'],
      merk: item['name'],
      weight: item['weight'],
      price: item['price'],
      total: item['total'],
      category: item['category'],
      imageUrl: item['imageUrl'],
      callback: callback,
    );
  }

  @override
  State<StatefulWidget> createState() {
    return _WideProductCard();
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '{ ${this.merk},${this.weight},${this.price},${this.total},${this.category},${this.imageUrl} }';
  }
}

class _WideProductCard extends State<WideProductCard> {
  @override
  void initState() {
    super.initState();
  }

  void handleCountChange(context) {
    setState(() {
      if (context == 'plus') widget.total++;
      if (context == 'minus')
        widget.total < 1 ? widget.total = 0 : widget.total--;
    });
    widget.callback();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double cardHeight = size.height / 6.5;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetail.routeName,
            arguments: ProductArguments(
                tag: widget.id + 'cart',
                id: widget.id,
                merk: widget.merk,
                category: widget.category,
                weight: widget.weight,
                price: widget.price,
                imageUrl: widget.imageUrl!));
      },
      child: Container(
        width: size.width,
        height: cardHeight,
        margin: EdgeInsets.only(
            top: kDefaultPadding / 2,
            bottom: kDefaultPadding / 6,
            left: kDefaultPadding,
            right: kDefaultPadding),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 8),
                  color: kShadowColor.withOpacity(0.23),
                  spreadRadius: -10,
                  blurRadius: 20)
            ],
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.id + 'cart',
                    child: widget.imageUrl == null
                        ? Image.asset(
                            'images/notFound.png',
                            height: cardHeight * 0.6,
                            width: size.width / 5,
                          )
                        : Image.network(
                            widget.imageUrl!,
                            height: cardHeight * 0.6,
                            width: size.width / 5,
                          ),
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
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: kDefaultPadding / 2, top: kDefaultPadding / 2),
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
                  Container(
                    margin: EdgeInsets.only(right: kDefaultPadding / 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Button(
                          width: 30,
                          height: 30,
                          onTap: () {
                            this.handleCountChange('minus');
                          },
                          margin: EdgeInsets.all(0),
                          padding: EdgeInsets.all(0),
                          color: kNaturalWhite.withOpacity(0.5),
                          child: Icon(
                            Icons.remove_outlined,
                            color: kBlackHint,
                            size: 15,
                          ),
                        ),
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
                        Button(
                          width: 30,
                          height: 30,
                          onTap: () {
                            this.handleCountChange('plus');
                          },
                          margin: EdgeInsets.all(0),
                          padding: EdgeInsets.all(0),
                          color: kNaturalWhite.withOpacity(0.5),
                          child: Icon(
                            Icons.add,
                            color: kBlackHint,
                            size: 15,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
