import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/constants/ApplicationColor.dart';
import 'package:grocery/custom_widget/Button.dart';
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
                return Button(
                  width: 82, 
                  height: 40, 
                  onTap: (){

                  }, 
                  padding: EdgeInsets.all(4),
                  borderRadius: BorderRadius.circular(50),
                  color: ApplicationColor.blackHint.withOpacity(0.2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("retry", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: ApplicationColor.blackHint),),
                    Icon(Icons.replay_outlined, size: 18,color: ApplicationColor.blackHint,),
                  ],
                ));
              }
              return Shimmer.fromColors(
                baseColor: ApplicationColor.shimmerBaseColor,
                highlightColor: ApplicationColor.shimmerHighlightColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FakeProductCard(),
                    FakeProductCard()
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
