import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/constants/ApplicationColor.dart';
import 'package:grocery/custom_widget/RetryButton.dart';
import 'package:grocery/product/WideProductCard.dart';
import 'package:grocery/services/HttpRequestService.dart';
import 'package:shimmer/shimmer.dart';

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
          padding: EdgeInsets.only(top: Application.defaultPadding / 2, left: Application.defaultPadding / 2, right: Application.defaultPadding / 2, bottom: Application.defaultPadding),
          child: FutureBuilder<List<WideProductCard>>(
            future: futureProduct,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: snapshot.data!,
                  crossAxisAlignment: CrossAxisAlignment.end,
                );
              } else if (snapshot.hasError) {
                return RetryButton(onTap: () {
                  
                },);
              }
              return Shimmer.fromColors(
                baseColor: ApplicationColor.shimmerBaseColor,
                highlightColor: ApplicationColor.shimmerHighlightColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FakeWideProductCard(),
                    FakeWideProductCard()
                  ],
                ),
              );
            },
          )),
    );
  }

  Future<List<WideProductCard>> fetchRecomendedProduct() async {
    final response = await HttpRequestService.sendRequest(method: HttpMethod.GET, url: Application.httBaseUrl + '/recommended-product.php');

    if (response.statusCode == 200) {
      List<dynamic> productList = jsonDecode(response.body)['data'];
      List<WideProductCard> productCardList = productList
          .map((dynamic item) => WideProductCard.fromJson(item))
          .toList();
      return productCardList;
    } else {
      throw Exception("failed load recomended products");
    }
  }
}
