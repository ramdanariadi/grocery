import 'package:flutter/material.dart';
import 'package:grocery/constrant.dart';
import 'package:grocery/product/ProductDetail.dart';

class ProductCard extends StatelessWidget {
  ProductCard(
      {Key? key,
      String? imageUrl,
      required this.id,
      required this.merk,
      required this.category,
      required this.weight,
      required this.price,
      this.margin})
      : super(key: key) {
    this.imageUrl = imageUrl;
  }

  final String id;
  final String merk;
  final String category;
  final int weight;
  final int price;
  String? imageUrl;
  double? margin;

  factory ProductCard.fromJson(Map<String, dynamic> item,
      {double? margin = null}) {
    return new ProductCard(
      id: item['id'],
      merk: item['name'],
      category: item['category'],
      weight: item['weight'],
      price: item['price'],
      imageUrl: item['imageUrl'],
      margin: margin,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.4,
      margin: EdgeInsets.only(
          left: margin != null ? margin! : kDefaultPadding / 2,
          right: margin != null ? margin! : kDefaultPadding / 2),
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
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ProductDetail.routeName,
                  arguments: ProductArguments(
                      id: this.id,
                      merk: this.merk,
                      category: this.category,
                      weight: this.weight,
                      price: this.price,
                      imageUrl: this.imageUrl!));
            },
            child: this.imageUrl == null
                ? Image.asset('images/notFound.png')
                : Image.network(this.imageUrl!),
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

class ProductArguments {
  final String id;
  final String merk;
  final String category;
  final int weight;
  final int price;
  final String imageUrl;

  ProductArguments(
      {required this.id,
      required this.merk,
      required this.category,
      required this.weight,
      required this.price,
      required this.imageUrl});
}
