import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/constants/ApplicationColor.dart';
import 'package:grocery/custom_widget/RetryButton.dart';
import 'package:grocery/custom_widget/Skeleteon.dart';
import 'package:grocery/product/ProductCard.dart';
import 'package:grocery/products/ProductGroupItems.dart';
import 'package:grocery/services/HttpRequestService.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class Products extends StatelessWidget {
  static final routeName = '/products';

  late Future<List<ProductGroupItems>> groupsFuture;

  Future<List<ProductGroupItems>> fetchCategory() async {
    final response = await HttpRequestService.sendRequest(method: HttpMethod.GET, url: Application.httBaseUrl + "/category");
    if (response.statusCode == 200) {
      List<dynamic> categories = jsonDecode(response.body)['data'];
      List<ProductGroupItems> productGroupItems =
          categories.map((e) => ProductGroupItems.fromJson(e)).toList();
      return productGroupItems;
    } else {
      throw Exception("failed load categories");
    }
  }

  @override
  Widget build(BuildContext context) {
    groupsFuture = this.fetchCategory();
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: Application.defaultPadding * 2.5),
            child: SingleChildScrollView(
              child: FutureBuilder<List<ProductGroupItems>>(
                future: groupsFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: snapshot.data!,
                    );
                  }
                  if (snapshot.hasError) {
                    return RetryButton(onTap: (){

                    });
                  }
                  return Shimmer.fromColors(
                    baseColor: ApplicationColor.shimmerBaseColor,
                    highlightColor: ApplicationColor.shimmerHighlightColor,
                    child: Container(
                      margin: EdgeInsets.only(top: Application.defaultPadding),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: Application.defaultPadding / 2),
                            child: FakeLabelWithActionButton(),
                          ),
                          SizedBox(height: 10,),
                          SingleChildScrollView(scrollDirection: Axis.horizontal,child: Row(children: [FakeProductCard(), FakeProductCard(), FakeProductCard()],)),
                          SizedBox(height: 20,),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: Application.defaultPadding / 2),
                            child: FakeLabelWithActionButton(),
                          ),
                          SizedBox(height: 10,),
                          SingleChildScrollView(scrollDirection: Axis.horizontal,child: Row(children: [FakeProductCard(), FakeProductCard(), FakeProductCard()],)),
                          SizedBox(height: 20,),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: Application.defaultPadding / 2),
                            child: FakeLabelWithActionButton(),
                          ),
                          SizedBox(height: 10,),
                          SingleChildScrollView(scrollDirection: Axis.horizontal,child: Row(children: [FakeProductCard(), FakeProductCard(), FakeProductCard()],)),
                          ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          // BottomNavBar(
          //   activeRoute: Products.routeName,
          // )
        ],
      ),
    );
  }
}

class FakeLabelWithActionButton extends StatelessWidget {
  const FakeLabelWithActionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Skeleton(widht: 140, height: 38),Skeleton(widht: 80, height: 30)],),);
  }
}
