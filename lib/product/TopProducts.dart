import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery/constant.dart';
import 'package:grocery/product/ProductCard.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class TopProducts extends StatelessWidget {
  TopProducts({
    Key? key,
  }) : super(key: key);

  late Future<List<ProductCard>> futureProductList;

  void initState() {
    futureProductList = this.fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    this.initState();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding / 2),
          child: FutureBuilder<List<ProductCard>>(
            future: futureProductList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: snapshot.data!,
                  crossAxisAlignment: CrossAxisAlignment.end,
                );
              } else if (snapshot.hasError) {
                return Text("Failed load product");
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
    );
  }

  Future<List<ProductCard>> fetchProduct() async {
    final response = await http.get(Uri.parse("$HTTP_BASE_URL/product/top"));

    if (response.statusCode == 200) {
      List<dynamic> productList = jsonDecode(response.body)['response'];
      List<ProductCard> productCardList = productList
          .map((dynamic item) => ProductCard.fromJson(item))
          .toList();
      return productCardList;
    } else {
      throw Exception("Failed load product");
    }
  }
}
