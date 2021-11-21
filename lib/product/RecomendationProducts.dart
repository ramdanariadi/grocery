import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery/constrant.dart';
import 'package:grocery/product/WideProductCard.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class RecomendationProducts extends StatelessWidget {
  RecomendationProducts({
    Key? key,
  }) : super(key: key);

  late Future<List<WideProductCard>> futureProduct;

  void init() {
    futureProduct = this.fetchRecomendedProduct();
  }

  @override
  Widget build(BuildContext context) {
    this.init();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding / 2),
          child: FutureBuilder<List<WideProductCard>>(
            future: futureProduct,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: snapshot.data!,
                  crossAxisAlignment: CrossAxisAlignment.end,
                );
              } else if (snapshot.hasError) {
                return Text("Filed laod recomedation products");
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          )),
    );
  }

  Future<List<WideProductCard>> fetchRecomendedProduct() async {
    final response =
        await http.get(Uri.parse('$HTTPBASEURL/product/recommendation'));

    if (response.statusCode == 200) {
      List<dynamic> productList = jsonDecode(response.body)['response'];
      List<WideProductCard> productCardList = productList
          .map((dynamic item) => WideProductCard.fromJson(item))
          .toList();
      return productCardList;
    } else {
      throw Exception("failed load recomended products");
    }
  }
}
