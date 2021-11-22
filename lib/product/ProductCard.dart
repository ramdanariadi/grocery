import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery/HttpRequestService.dart';
import 'package:grocery/constrant.dart';
import 'package:grocery/custom_widget/Button.dart';
import 'package:grocery/product/ProductDetail.dart';
import 'package:grocery/profile/Login.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class ProductCard extends StatelessWidget {
  ProductCard(
      {Key? key,
      String? imageUrl,
      required this.id,
      required this.merk,
      required this.category,
      required this.weight,
      required this.price,
      double? margin})
      : super(key: key) {
    this.imageUrl = imageUrl;
    this.margin = margin ?? kDefaultPadding / 2;
  }

  final String id;
  final String merk;
  final String category;
  final int weight;
  final int price;
  String? imageUrl;
  late double margin;

  factory ProductCard.fromJson(Map<String, dynamic> item, {double? margin}) {
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

  Future<void> addToChart() async {
    final response = await HttpRequestService.post(
        url:
            '$HTTPBASEURL/cart/ac723ce6-11d2-11ec-82a8-0242ac130003/${this.id}/1',
        needHeader: true);
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (responseBody['metaData']['code'] == 201) {
        Fluttertoast.showToast(msg: "yeay product added");
      }
    } else {
      Fluttertoast.showToast(msg: "opps something wrong");
      debugPrint(response.body.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetail.routeName,
            arguments: ProductArguments(
                id: this.id,
                tag: this.id + 'top',
                merk: this.merk,
                category: this.category,
                weight: this.weight,
                price: this.price,
                imageUrl: this.imageUrl));
      },
      child: Container(
        width: size.width * 0.4,
        margin: EdgeInsets.only(left: margin, right: margin),
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
            Hero(
                tag: this.id + 'top',
                child: this.imageUrl == null
                    ? Image.asset(
                        'images/notFound.png',
                        height: 120,
                      )
                    : Image.network(
                        this.imageUrl!,
                        height: 120,
                      )),
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
                  Button(
                      text: "plus",
                      child: Center(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                      width: 30,
                      height: 30,
                      padding: EdgeInsets.all(0),
                      onTap: () async {
                        if (await HttpRequestService.isAuthenticated()) {
                          this.addToChart();
                        } else {
                          Navigator.pushNamed(context, Login.routeName);
                        }
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProductArguments {
  final String id;
  final String tag;
  final String merk;
  final String category;
  final int weight;
  final int price;
  String? imageUrl;

  ProductArguments(
      {required this.id,
      required this.tag,
      required this.merk,
      required this.category,
      required this.weight,
      required this.price,
      required this.imageUrl});
}
