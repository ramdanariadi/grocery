import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/constants/ApplicationColor.dart';
import 'package:grocery/custom_widget/Button.dart';
import 'package:grocery/custom_widget/Skeleteon.dart';
import 'package:grocery/products/Products.dart';
import 'package:grocery/services/HttpRequestService.dart';
import 'package:grocery/state_manager/RouterState.dart';
import 'ProductCard.dart';
import 'ProductDetail.dart';

// ignore: must_be_immutable
class WideProductCard extends StatelessWidget {
  WideProductCard({
    Key? key,
    required this.id,
    required this.shopId,
    required this.shopName,
    required this.merk,
    required this.category,
    required this.weight,
    required this.price,
    String? imageUrl,
  }) : super(key: key) {
    this.imageUrl = imageUrl;
  }

  final String id;
  final String shopId;
  final String shopName;
  final String merk;
  final int weight;
  final int price;
  final String category;
  String? imageUrl;

  Future<void> addToChart() async {
    final response = await HttpRequestService.sendRequest(
        method: HttpMethod.GET,
        url: Application.httBaseUrl +
            '/cart/ac723ce6-11d2-11ec-82a8-0242ac130003/${this.id}/1');
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

  factory WideProductCard.fromJson(Map<String, dynamic> item) {
    return new WideProductCard(
        id: item['id'],
        shopId: item['shopId'],
        shopName: item['shopName'],
        merk: item['name'],
        weight: item['weight'],
        price: item['price'],
        category: item['category'],
        imageUrl: item['imageUrl']);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    RouterState routerState = BlocProvider.of<RouterState>(context);
    return GestureDetector(
      onTap: () {
        routerState.go(
            context: context,
            baseRoute: Products.routeName,
            path: ProductDetail.routeName,
            extra: ProductArguments(
                id: id,
                shopId: shopId,
                shopName: shopName,
                tag: id + 'recomend',
                merk: merk,
                category: category,
                weight: weight,
                price: price,
                imageUrl: this.imageUrl!));
      },
      child: Container(
        width: size.width * 0.65,
        padding:
            EdgeInsets.symmetric(horizontal: Application.defaultPadding / 2),
        margin: EdgeInsets.only(
            left: Application.defaultPadding / 2,
            right: Application.defaultPadding / 2),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 8),
                  color: ApplicationColor.shadowColor.withOpacity(0.23),
                  spreadRadius: -10,
                  blurRadius: 20)
            ],
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Hero(
              tag: this.id + 'recomend',
              child: this.imageUrl == null
                  ? Image.asset(
                      'images/notFound.png',
                      width: size.width / 5,
                    )
                  : Image.network(
                      this.imageUrl!,
                      // width: size.width / 5,
                      height: size.width / 3.8,
                    ),
            ),
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
                        style: TextStyle(
                            height: 1.5, color: ApplicationColor.blackHint)),
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
                        style: TextStyle(
                            height: 1.5, color: ApplicationColor.blackHint)),
                  ])),
                  SizedBox(
                    width: Application.defaultPadding,
                  ),
                  Button(
                      text: "plus",
                      color: ApplicationColor.primaryColor,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 15,
                      ),
                      width: 30,
                      height: 30,
                      padding: EdgeInsets.all(0),
                      onTap: () {
                        this.addToChart();
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

class FakeWideProductCard extends StatelessWidget {
  const FakeWideProductCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.65,
      margin: EdgeInsets.only(left: Application.defaultPadding / 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Skeleton(widht: size.width / 5, height: 80),
          Padding(
            padding: EdgeInsets.all(Application.defaultPadding / 2.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Skeleton(widht: size.width / 5, height: 12),
                SizedBox(
                  height: 10,
                ),
                Skeleton(widht: size.width / 4, height: 12),
                SizedBox(
                  height: 10,
                ),
                Skeleton(widht: size.width / 5, height: 12)
              ],
            ),
          ),
          Skeleton(widht: 30, height: 30)
        ],
      ),
    );
  }
}
