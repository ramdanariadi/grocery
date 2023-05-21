import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/constants/ApplicationColor.dart';
import 'package:grocery/custom_widget/RetryButton.dart';
import 'package:grocery/product/ProductCard.dart';
import 'package:grocery/services/HttpRequestService.dart';
import 'package:shimmer/shimmer.dart';

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
          padding: EdgeInsets.all(Application.defaultPadding / 2),
          child: FutureBuilder<List<ProductCard>>(
            future: futureProductList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: snapshot.data!,
                  crossAxisAlignment: CrossAxisAlignment.end,
                );
              } else if (snapshot.hasError) {
                return RetryButton(onTap: (){

                });
              }
              return Shimmer.fromColors(
                baseColor: ApplicationColor.shimmerBaseColor,
                highlightColor: ApplicationColor.shimmerHighlightColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [FakeProductCard(),FakeProductCard(),FakeProductCard()]),
              );
            },
          )),
    );
  }

  Future<List<ProductCard>> fetchProduct() async {
    final response = await HttpRequestService.sendRequest(method:HttpMethod.GET, url: Application.httBaseUrl + "/product?isTop=true&pageIndex=0&pageSize=10");

    if (response.statusCode == 200) {
      List<dynamic> productList = jsonDecode(response.body)['data'];
      List<ProductCard> productCardList = productList
          .map((dynamic item) => ProductCard.fromJson(item))
          .toList();
      return productCardList;
    } else {
      throw Exception("Failed load product");
    }
  }
}