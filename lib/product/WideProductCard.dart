import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery/constrant.dart';
import 'package:grocery/custom_widget/Button.dart';
import 'package:http/http.dart' as http;
import 'ProductCard.dart';
import 'ProductDetail.dart';

class WideProductCard extends StatelessWidget {
  const WideProductCard({
    Key? key,
    required this.id,
    required this.merk,
    required this.category,
    required this.weight,
    required this.price,
    required this.imageUrl,
  }) : super(key: key);

  final String id;
  final String merk;
  final int weight;
  final int price;
  final String category;
  final String imageUrl;

  Future<void> addToChart() async {
    final response = await http.post(Uri.parse(HTTPBASEURL +
        '/chart/ac723ce6-11d2-11ec-82a8-0242ac130003/${this.id}/1'));
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
                      id: id,
                      merk: merk,
                      category: category,
                      weight: weight,
                      price: price,
                      imageUrl: imageUrl));
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
                Button(
                    text: "plus",
                    child: Image.asset(
                      "images/icons/PlusOutline.png",
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    width: 30,
                    height: 30,
                    onTap: () {
                      this.addToChart();
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}
