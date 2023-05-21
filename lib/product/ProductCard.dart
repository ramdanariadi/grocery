import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery/custom_widget/Skeleteon.dart';
import 'package:grocery/products/Products.dart';
import 'package:grocery/services/HttpRequestService.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/constants/ApplicationColor.dart';
import 'package:grocery/custom_widget/Button.dart';
import 'package:grocery/product/ProductDetail.dart';
import 'package:grocery/profile/Login.dart';
import 'package:grocery/services/UserService.dart';

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
    this.margin = margin ?? Application.defaultPadding / 2;
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
    final response = await HttpRequestService.sendRequest(method: HttpMethod.POST,
        url:
            Application.httBaseUrl + '/cart/${this.id}/1',
        isSecure: true);
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
        GoRouter.of(context).go(Products.routeName +"/"+ ProductDetail.routeName,
            extra: ProductArguments(
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
                  color: ApplicationColor.naturalWhite.withOpacity(0.23),
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
              padding: EdgeInsets.all(Application.defaultPadding / 2),
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
                            color: ApplicationColor.blackHint,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: "weight ",
                        style: TextStyle(height: 1.5, color: ApplicationColor.blackHint)),
                    TextSpan(
                        text: "${this.weight}g\n",
                        style: TextStyle(
                            height: 1.5,
                            color: ApplicationColor.blackHint,
                            fontWeight: FontWeight.w500)),
                    TextSpan(
                        text: "\$${this.price}",
                        style: TextStyle(
                            height: 1.5,
                            color: ApplicationColor.blackHint,
                            fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: "/kg",
                        style: TextStyle(height: 1.5, color: ApplicationColor.blackHint)),
                  ])),
                  Button(
                      text: "plus",
                      color: ApplicationColor.primaryColor,
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
                        if (await UserService.isAuthenticated()) {
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

class FakeProductCard extends StatelessWidget {
  FakeProductCard({ Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: Application.defaultPadding / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Skeleton(widht: size.width * 0.4, height: 100),
          SizedBox(height: 10,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Skeleton(widht: size.width * 0.22, height: 12),
                  SizedBox(height: 10,),
                  Skeleton(widht: size.width * 0.3, height: 12),
                  SizedBox(height: 10,),
                  Skeleton(widht: size.width * 0.2, height: 12)
                  ],
              ),
              SizedBox(width: 10,),
              Skeleton(widht: 30, height: 30)
            ],
          )
        ],
      ),
    );
  }
}
